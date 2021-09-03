import 'package:flutter/material.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';

void _showErrorDialog(String title, String msg, BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            backgroundColor: ColorConstants.background,
            title: Text(title),
            content: Text(msg),
            titleTextStyle: TextStyle(color: ColorConstants.errorText),
            contentTextStyle: TextStyle(color: ColorConstants.bodyText),
            actions: <Widget>[
              TextButton(
                child: Text('Try Again'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ));
}
