import 'package:flutter/material.dart';

Future<dynamic> regErrorPopUp(BuildContext context,String error) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder(
        future: Future.delayed(
            Duration(
              seconds: 1,
            ), () {
          return '';
        }),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData)
            return AlertDialog(content: LinearProgressIndicator());
          else
            return AlertDialog(
              title: Text("Error! "),
              content: Text("$error"),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                FlatButton(
                  onPressed: () => Navigator.pushNamed(context, '/log'),
                  child: Text('Go to Login'),
                  color: Colors.grey[800],
                ),
              ],
            );
        },
      );
    },
  );
}

Future<dynamic> loginErrorPopUp(BuildContext context,String error) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder(
        future: Future.delayed(
            Duration(
              seconds: 1,
            ), () {
          return '';
        }),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData)
            return AlertDialog(content: LinearProgressIndicator());
          else
            return AlertDialog(
              title: Text("Error! "),
              content: Text("$error"),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
                FlatButton(
                  onPressed: () => Navigator.pushNamed(context, '/reg'),
                  child: Text('Go to Register'),
                  color: Colors.grey[800],
                ),
              ],
            );
        },
      );
    },
  );
}

Future<dynamic> signOutPopUp(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder(
        future: Future.delayed(
            Duration(
              seconds: 1,
            ), () {
          return '';
        }),
        builder: (futureContext, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData)
            return AlertDialog(content: LinearProgressIndicator());
          else {
            Future.delayed(
                Duration(seconds: 1), () => Navigator.of(context).pop());
            //Navigator.pushNamed(futureContext, '/');
            return AlertDialog(title: Text('Signed out!'));
          }
        },
      );
    },
  );
}

delayProgress(BuildContext context,String tag, int seconds) async {
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return FutureBuilder(
        future: Future.delayed(Duration(seconds: seconds), () => ''),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return AlertDialog(
              content: LinearProgressIndicator(),
            );
          Navigator.of(context).pop();
          return AlertDialog(
            title: Text('$tag successfully!'),
          );
        },
      );
    },
  );
}
