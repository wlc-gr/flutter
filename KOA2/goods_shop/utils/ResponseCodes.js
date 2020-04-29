/**
 * Created by lipeng on 17/8/6.
 */
/**
 * API错误名称
 */
let ResponseCodes = {};
ResponseCodes.UNKNOW_ERROR = "-1";
ResponseCodes.USER_NOT_EXIST = "-2";
ResponseCodes.USER_EXIST = "-3";
ResponseCodes.DBERROR = "-4";
/**
 * API错误名称对应的错误信息
 */
const error_map = new Map();
error_map.set(ResponseCodes.UNKNOW_ERROR,  '未知错误');
error_map.set(ResponseCodes.USER_NOT_EXIST,  '用户不存在');
error_map.set(ResponseCodes.USER_EXIST,  '用户名已存在');
error_map.set(ResponseCodes.DBERROR,  '数据库连接错误');

//根据错误名称获取错误信息
ResponseCodes.getErrorInfo = (error_name) => {
    var error_info;
    if (error_name) {
        error_info = error_map.get(error_name);
    }
    //如果没有对应的错误信息，默认'未知错误'
    if (!error_info) {
        error_name = ResponseCodes.UNKNOW_ERROR;
        error_info = error_map.get(error_name);
    }
    return error_info;
}

module.exports = ResponseCodes;
