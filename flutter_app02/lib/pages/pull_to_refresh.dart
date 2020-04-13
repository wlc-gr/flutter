import 'package:flutter/material.dart';
import '../utils/DioHelper.dart';

class PullToRefreshPage extends StatefulWidget {
  @override
  _PullToRefreshPageState createState() => _PullToRefreshPageState();
}

class _PullToRefreshPageState extends State<PullToRefreshPage> {
  List _userList = []; //初始化用户列表
  int _curPage = 1;
  int _pageSize = 20;
  int _pages = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    _userList = null;
    _curPage = null;
    _pageSize = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //加载数据
    _getUserList();
    //监听滚动条变化
    _scrollController.addListener(() {
      if (this._scrollController.position.pixels >
          this._scrollController.position.maxScrollExtent - 40) {
        print('------ ${this._scrollController.position.pixels}--------');
        print('------ ${this._scrollController.position.maxScrollExtent}--------');
        _getUserList();
      }
    });
  }

  void _getUserList() async {
    if (this._curPage <= this._pages) {
      var res = await DioHelper().getAsync(
        url: "/basicComponents/pc/sys/user/find",
        params: {"curPage": this._curPage, "pageSize": this._pageSize},
      );
      setState(() {
        _userList.addAll(res['data']['list']);
        this._pages = res['data']['pages'] is int
            ? res['data']['pages']
            : int.tryParse(res['data']['pages']);
        this._curPage = res['data']['curPage'] is int
            ? res['data']['curPage'] + 1
            : int.tryParse(res['data']['curPage']) + 1;
      });
      print('------------------->${this._curPage}');
      print('------------------->${this._userList.length}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(color: Colors.green);
    return Scaffold(
      appBar: AppBar(
        title: Text('上拉分页加载更多'),
      ),
      body: ListView.separated(
          controller: this._scrollController,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${this._userList[index]["name"]}'),
            );
          },
          separatorBuilder: (context, index) {
            return index % 2 == 0 ? divider1 : divider2;
          },
          itemCount: this._userList.length),
      floatingActionButton: this._curPage < 3
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _scrollController.animateTo(0.0,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              },
            ),
    );
  }
}
