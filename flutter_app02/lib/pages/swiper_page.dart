import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MySwiperPage extends StatefulWidget {
  @override
  _MySwiperPageState createState() => _MySwiperPageState();
}

class _MySwiperPageState extends State<MySwiperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("轮播图")),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 150,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Swiper(
                  itemBuilder: (context, index) {
                    return Image.network(
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586470011965&di=e74852bfd0950de66e7446917d339d17&imgtype=0&src=http%3A%2F%2F2b.zol-img.com.cn%2Fproduct%2F61_940x705%2F83%2Fce9MEqItt60go.jpg",
                      fit: BoxFit.cover,
                    );
                  },
                  itemCount: 3,
                  pagination: SwiperPagination(),
                  control: SwiperControl()),
            ),
          )
        ],
      ),
    );
  }
}
