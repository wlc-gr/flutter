import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';

///http请求成功回调
typedef HttpSuccessCallback<T> = void Function(dynamic data);

/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

///Http配置.
class HttpConfig {
  /// constructor.
  HttpConfig(
    @required this.baseUrl, {
    this.options,
    this.pem,
    this.pKCSPath,
    this.pKCSPwd,
    this.interceptors,
  });

  /// Options.
  BaseOptions options;

  String baseUrl;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PEM证书内容.
  String pem;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书路径.
  String pKCSPath;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书密码.
  String pKCSPwd;
  List<Interceptor> interceptors;

  HttpConfig setCookie(String cookie) {
    Map<String, dynamic> _headers = new Map();
    _headers["Cookie"] = cookie;
    this.options.headers.addAll(_headers);
    return this;
  }
}

/**
 * 封装Dio工具库,单例,
 */
class DioHelper {
  ///超时时间
  static const CONNECT_TIMEOUT = 30000;
  static const RECEIVE_TIMEOUT = 30000;

  /// PEM证书内容.
  String _pem;

  /// PKCS12 证书路径.
  String _pKCSPath;

  /// PKCS12 证书密码.
  String _pKCSPwd;

  ///同一个CancelToken可以用于多个请求，当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消，一个页面对应一个CancelToken。
  Map<String, CancelToken> _cancelTokens = Map<String, CancelToken>();
  static final DioHelper _instance = DioHelper._init();
  static Dio _client;

  factory DioHelper() => _instance;

  Dio get client => _client;

  /// Options.
  BaseOptions get _options => _client.options;

  DioHelper._init() {
    if (_client == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      _client = Dio(options);
    }
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void setConfig(HttpConfig config) {
    _mergeOption(config.options ?? BaseOptions(baseUrl: config.baseUrl));
    if (config.interceptors != null && config.interceptors.isNotEmpty) {
      _client.interceptors..addAll(config.interceptors);
    }
    _pem = config.pem ?? _pem;
    if (_client != null) {
      _client.options = _options;
      if (_pem != null) {
        (_client.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            if (cert.pem == _pem) {
              // 证书一致，则放行
              return true;
            }
            return false;
          };
        };
      }
      if (_pKCSPath != null) {
        (_client.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (HttpClient client) {
          SecurityContext sc = new SecurityContext();
          //file为证书路径
          sc.setTrustedCertificates(_pKCSPath, password: _pKCSPwd);
          HttpClient httpClient = new HttpClient(context: sc);
          return httpClient;
        };
      }
    }
  }

  ///Get网络请求
  ///[url] 网络请求地址不包含域名
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<Response> getAsync({
    @required String url,
    Map<String, dynamic> params,
    Options options,
    String tag,
  }) async {
    return _requestAsync(
      path: url,
      method: Method.get,
      params: params,
      tag: tag,
    );
  }

  ///post网络请求
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  Future<Response> postAsync({
    @required String url,
    data,
    Map<String, dynamic> params,
    Options options,
    String tag,
  }) {
    return _requestAsync(
      path: url,
      data: data,
      method: Method.post,
      params: params,
      tag: tag,
    );
  }

  ///统一网络请求
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<Response> _requestAsync({
    @required String path,
    String method,
    data,
    Map<String, dynamic> params,
    Options options,
    String tag,
  }) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("请求网络异常，请稍后重试！");
      return new Future.error(new DioError(
        response: Response(data: '网络异常，请稍后重试！'),
        error: "网络异常，请稍后重试！",
        type: DioErrorType.RESPONSE,
      ));
    }
    //设置默认值
    params = params ?? {};
    options = _checkOptions(method, options);
    path = _restfulUrl(path, params);
    try {
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }

      Response response = await _client.request(path,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return response;
      }
      return response;
    } on DioError catch (e, s) {
      print("请求出错：$e\n$s");
      if (e.type != DioErrorType.CANCEL)
        return new Future.error(new DioError(
          response: Response(data: '请求出错$e\n$s！'),
          error: "请求出错$e\n$s！",
          type: DioErrorType.RESPONSE,
        ));
    } catch (e, s) {
      print("未知异常出错：$e\n$s");
      return new Future.error(new DioError(
        response: Response(data: '未知异常出错$e\n$s！'),
        error: "未知异常出错$e\n$s！",
        type: DioErrorType.RESPONSE,
      ));
    }
  }

  ///Get网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[tag] 请求统一标识，用于取消网络请求
  void get({
    @required String url,
    Map<String, dynamic> params,
    Options options,
    @required HttpSuccessCallback successCallback,
    String tag,
  }) async {
    _request(
      url: url,
      params: params,
      method: Method.get,
      successCallback: successCallback,
      tag: tag ?? Method.get,
    );
  }

  ///post网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[tag] 请求统一标识，用于取消网络请求
  void post({
    @required String url,
    data,
    Map<String, dynamic> params,
    Options options,
    @required HttpSuccessCallback successCallback,
    String tag,
  }) async {
    _request(
      url: url,
      data: data,
      method: Method.post,
      params: params,
      successCallback: successCallback,
      tag: tag ?? Method.post,
    );
  }

  ///统一网络请求
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[tag] 请求统一标识，用于取消网络请求
  void _request({
    @required String url,
    String method,
    data,
    Map<String, dynamic> params,
    Options options,
    @required HttpSuccessCallback successCallback,
    String tag,
  }) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("请求网络异常，请稍后重试！");
      throw new DioError(
        response: Response(data: '网络异常，请稍后重试！'),
        error: "网络异常，请稍后重试！",
        type: DioErrorType.RESPONSE,
      );
    }
    //设置默认值
    params = params ?? {};
    method = method ?? Method.post;
    options = _checkOptions(method, options);
    url = _restfulUrl(url, params);
    try {
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }
      Response<Map<String, dynamic>> response = await _client.request(url,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      successCallback(response);
    } on DioError catch (e, s) {
      print("请求出错：$e\n$s");
      if (e.type != DioErrorType.CANCEL)
        throw new DioError(
          response: Response(data: '请求出错$e\n$s'),
          error: "请求出错$e\n$s",
          type: DioErrorType.RESPONSE,
        );
    } catch (e, s) {
      print("未知异常出错：$e\n$s");
      throw new DioError(
        response: Response(data: '未知异常出错$e\n$s'),
        error: "未知异常出错$e\n$s",
        type: DioErrorType.RESPONSE,
      );
    }
  }

  ///下载文件
  ///
  ///[url] 下载地址
  ///[savePath]  文件保存路径
  ///[onReceiveProgress]  文件保存路径
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  void download({
    @required String url,
    @required savePath,
    ProgressCallback onReceiveProgress,
    Map<String, dynamic> params,
    data,
    Options options,
    @required HttpSuccessCallback successCallback,
    String tag,
  }) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("请求网络异常，请稍后重试！");
      throw new DioError(
        response: Response(data: '请求网络异常，请稍后重试！'),
        error: "请求网络异常，请稍后重试！",
        type: DioErrorType.RESPONSE,
      );
    }

    ////0代表不设置超时
    int receiveTimeout = 0;
    options ??= options == null
        ? Options(receiveTimeout: receiveTimeout)
        : options.merge(receiveTimeout: receiveTimeout);

    //设置默认值
    params = params ?? {};
    url = _restfulUrl(url, params);

    try {
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }

      Response response = await _client.download(url, savePath,
          onReceiveProgress: onReceiveProgress,
          queryParameters: params,
          data: data,
          options: options,
          cancelToken: cancelToken);
      //成功
      successCallback(response.data);
    } on DioError catch (e, s) {
      if (e.type != DioErrorType.CANCEL) {
        print("请求出错：$e\n$s");
        throw new DioError(
          response: Response(data: '请求出错：$e\n$s！'),
          error: "请求出错：$e\n$s！",
          type: DioErrorType.RESPONSE,
        );
      }
    } catch (e, s) {
      print("未知异常出错：$e\n$s");
      throw new DioError(
        response: Response(data: '未知异常出错：$e\n$s！'),
        error: "未知异常出错：$e\n$s！",
        type: DioErrorType.RESPONSE,
      );
    }
  }

  /// merge Option.
  void _mergeOption(BaseOptions opt) {
    _options.method = opt.method ?? _options.method;
    _options.headers = (new Map.from(_options.headers))..addAll(opt.headers);
    _options.baseUrl = opt.baseUrl ?? _options.baseUrl;
    _options.connectTimeout = opt.connectTimeout ?? _options.connectTimeout;
    _options.receiveTimeout = opt.receiveTimeout ?? _options.receiveTimeout;
    _options.responseType = opt.responseType ?? _options.responseType;
    _options.extra = (new Map.from(_options.extra))..addAll(opt.extra);
    _options.contentType = opt.contentType ?? _options.contentType;
    _options.validateStatus = opt.validateStatus ?? _options.validateStatus;
    _options.followRedirects = opt.followRedirects ?? _options.followRedirects;
  }

  ///上传文件
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[onSendProgress] 上传进度
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[tag] 请求统一标识，用于取消网络请求
  void upload({
    @required String url,
    @required FormData data,
    ProgressCallback onSendProgress,
    Map<String, dynamic> params,
    Options options,
    @required HttpSuccessCallback successCallback,
    String tag,
  }) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("请求网络异常，请稍后重试！");
      throw new DioError(
        response: Response(data: '请求网络异常，请稍后重试！'),
        error: "请求网络异常，请稍后重试！",
        type: DioErrorType.RESPONSE,
      );
    }

    //设置默认值
    params = params ?? {};
    //强制 POST 请求
    options = _checkOptions(Method.post, options);
    url = _restfulUrl(url, params);

    try {
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }

      Response<Map<String, dynamic>> response = await _client.request(url,
          onSendProgress: onSendProgress,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      //成功
      successCallback(response);
    } on DioError catch (e, s) {
      if (e.type != DioErrorType.CANCEL) {
        print("请求出错：$e\n$s");
        throw new DioError(
          response: Response(data: '请求出错：$e\n$s！'),
          error: "请求出错：$e\n$s！",
          type: DioErrorType.RESPONSE,
        );
      }
    } catch (e, s) {
      print("未知异常出错：$e\n$s");
      throw new DioError(
        response: Response(data: '未知异常出错：$e\n$s！'),
        error: "未知异常出错：$e\n$s！",
        type: DioErrorType.RESPONSE,
      );
    }
  }

  static Dio createNewDio([BaseOptions options]) {
    Dio dio = new Dio(options);
    return dio;
  }

  /// check Options.
  Options _checkOptions(method, options) {
    options = options ?? Options(method: method ?? Method.get);
    return options;
  }

  ///取消网络请求
  void cancel(String tag) {
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag].isCancelled) {
        _cancelTokens[tag].cancel();
      }
      _cancelTokens.remove(tag);
    }
  }

  ///restful处理
  String _restfulUrl(String url, Map<String, dynamic> params) {
    // restful 请求处理
    // /gysw/search/hist/:user_id        user_id=27
    // 最终生成 url 为     /gysw/search/hist/27{}
    if (params == null || params.isEmpty) {
      return url;
    }
    params.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    return url;
  }
}
