import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class MyStepProgressPage extends StatefulWidget {
  @override
  _MyStepProgressPageState createState() => _MyStepProgressPageState();
}

class _MyStepProgressPageState extends State<MyStepProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('步骤进度条'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('步骤进度条'),
                SizedBox(
                  height: 5,
                ),
                StepProgressIndicator(
                  totalSteps: 6,
                  currentStep: 2,
                  selectedColor: Colors.black,
                  unselectedColor: Colors.grey[200],
                  customStep: (index, color, _) => color == Colors.black
                      ? Builder(
                          builder: (context) {
                            return MyStepItem(color);
                          },
                        )
                      : Container(
                          color: color,
                          child: Icon(
                            Icons.add,
                          ),
                        ),
//                  customColor: (index) => index == 0
//                      ? Colors.red
//                      : index == 4 ? Colors.black : Colors.green,
                  size: 40,
                  progressDirection: TextDirection.ltr,
//                  direction: Axis.vertical,
                ),
                CircularStepProgressIndicator(
                  totalSteps: 20,
                  currentStep: 6,
                  selectedColor: Colors.cyan,
                  unselectedColor: Colors.yellowAccent,
                  selectedStepSize: 3.0,
                  unselectedStepSize: 9.0,
                  width: 100,
                ),
              ],
            ),
          ),
        ));
  }
}

class MyStepItem extends StatelessWidget {
  Color color;

  MyStepItem(@required this.color) : assert(color != null, 'color不能为空');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: this.color),
    );
  }
}
