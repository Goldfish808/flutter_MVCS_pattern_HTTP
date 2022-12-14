import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({required this.msg, Key? key}) : super(key: key);

  final msg;
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("${msg}"),
      actions: [
        CupertinoDialogAction(
          child: Text("확인"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
