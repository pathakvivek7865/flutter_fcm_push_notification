import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  final Map<String, dynamic> msg;
  final bool isOpen;
  NextPage(this.msg, [this.isOpen]);
  @override
  State<StatefulWidget> createState() {
    return _NextPage(msg, isOpen);
  }
}

class _NextPage extends State<NextPage> {
  Map<String, dynamic> msg;
  final bool _isOpen;
  _NextPage(this.msg, this._isOpen);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Data:",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Id:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                _isOpen == true
                    ? Text(
                        msg['data']['id'].toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    : Text(
                        msg['id'].toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Link:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Flexible(
                  child: _isOpen == true
                      ? Text(
                          msg['data']['link'].toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      : Text(
                          msg['link'].toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Message:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Flexible(
                  child: _isOpen == true
                      ? Text(
                          msg['data']['message'].toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      : Text(
                          msg['message'].toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
