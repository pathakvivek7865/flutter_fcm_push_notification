import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';

import './next_page.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  var textValue = "";

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        setState(() {
          textValue = msg.toString();
        });
        print("onLaunch called");

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NextPage(msg, false)));
      },
      onResume: (
        Map<String, dynamic> msg,
      ) {
        print("onResume called");
        print(msg);
        setState(() {
          textValue = msg.toString();
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NextPage(msg, false)));
      },
      onMessage: (Map<String, dynamic> msg) {
        print("onMessage called");
        print(msg);
        setState(() {
          textValue = msg.toString();
        });

        showAlertDialog(msg);
      },
    );

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));

    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print("IOS Setting Registerd");
    });

    firebaseMessaging.getToken().then((token) {
      update(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push Notification"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text(
            "Welcome",
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.cyan),
          ),
          Text(textValue),
        ],
      )),
    );
  }

  void update(String token) {
    print(token);
    DatabaseReference databaseReference = FirebaseDatabase().reference();
    databaseReference.child("fcm-token/$token").set({"token": token});
    setState(() {
      //textValue = token;
    });
  }

  void showAlertDialog(Map<String, dynamic> msg) {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap on buttons
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(msg['notification']['title'].toString()),
            content: Text(msg['notification']['body'].toString()),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Open"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              NextPage(msg, true)));
                },
              ),
            ],
          );
        });
  }
}
