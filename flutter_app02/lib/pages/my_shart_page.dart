import 'package:flutter/material.dart';
import 'package:share/share.dart';



//定义分享页面
class MyShartPage extends StatefulWidget {
  @override
  _MyShartPageState createState() => _MyShartPageState();
}

class _MyShartPageState extends State<MyShartPage> {
  String text = '';
  String subject = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('分享插件演示')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Share text:',
                hintText: 'Enter some text and/or link to share',
              ),
              maxLines: 2,
              onChanged: (String value) => setState(() {
                text = value;
              }),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Share subject:',
                hintText: 'Enter subject to share (optional)',
              ),
              maxLines: 2,
              onChanged: (String value) => setState(() {
                subject = value;
              }),
            ),
            const Padding(padding: EdgeInsets.only(top: 24.0)),
            Builder(
              builder: (BuildContext context) {
                return RaisedButton(
                  child: const Text('Share'),
                  onPressed: text.isEmpty
                      ? null
                      : () {
                          final RenderBox box = context.findRenderObject();
                          Share.share(text,
                              subject: subject,
                              sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) & box.size);
                        },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
