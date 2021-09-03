import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'dart:ui';

@override
class _DropDownState extends State<Dropdown> {
  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.pushNamed(context, RoutesConstants.homeRoute);
        break;
      case 1:
        Navigator.pushNamed(context, RoutesConstants.myProfileRoute);
        break;
      case 2:
        Navigator.pushNamed(context, RoutesConstants.addMoneyRoute);
        break;
      case 3:
        Navigator.pushNamed(context, RoutesConstants.resetPasswordRoute);
        break;
      case 4:
        var response;
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                    content: Text("Are you sure you want to log out?"),
                    backgroundColor: ColorConstants.background,
                    contentTextStyle: TextStyle(color: ColorConstants.bodyText),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () {
                          response = Response('Logging out...', 401);
                          print(response.body);
                          print(response.statusCode);
                          Navigator.pushNamed(
                              context, RoutesConstants.loginRoute);
                          if (response.statusCode == 401) {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                        content: Text(
                                            "You have successfully logged out."),
                                        backgroundColor:
                                            ColorConstants.background,
                                        contentTextStyle: TextStyle(
                                            color: ColorConstants.bodyText),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(ctx).pop(context);
                                            },
                                          )
                                        ]));
                          }
                        },
                      ),
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(ctx).pop(context);
                        },
                      )
                    ]));

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: ColorConstants.expandable,
      icon: Icon(Icons.menu),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
            value: 0,
            child: Text(
              "Home",
              style: TextStyle(color: ColorConstants.bodyText),
            )),
        PopupMenuItem<int>(
            value: 1,
            child: Text(
              "View Portfolio",
              style: TextStyle(color: ColorConstants.bodyText),
            )),
        PopupMenuItem<int>(
            value: 2,
            child: Text(
              "Add Money",
              style: TextStyle(color: ColorConstants.bodyText),
            )),
        PopupMenuItem<int>(
            value: 3,
            child: Text(
              "Reset Password",
              style: TextStyle(color: ColorConstants.bodyText),
            )),
        PopupMenuDivider(),
        PopupMenuItem<int>(
            value: 4,
            child: Text(
              "Log Out",
              style: TextStyle(color: ColorConstants.bodyText),
            )),
      ],
      onSelected: (item) => SelectedItem(context, item),
    );
  }
}

class Dropdown extends StatefulWidget {
  @override
  _DropDownState createState() {
    return _DropDownState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: ColorConstants.bodyText,
              displayColor: ColorConstants.bodyText,
            ),
      ),
    );
  }
}
