import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/errorsHandlers/LAndR_errorHandler.dart';
import 'package:flutter_firebase_practice/services/auth.dart';
import 'package:flutter_firebase_practice/services/csvCreation.dart';
import '../services/Db_firestore.dart';

class DropDown extends StatelessWidget {
  final bool isAdmin;
  final BuildContext scaffCtx;
  DropDown(this.isAdmin,this.scaffCtx);

  @override
  Widget build(BuildContext context) {
    return new DropdownButton<String>(
      items: <String>[isAdmin ? 'Reset Data' : '', 'Download Sheet', 'Sign out']
          .map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          })
          .where((element) => element.value != '')
          .toList(),
      onChanged: (value) async {
        if (value == 'Sign out') {
          await auth.signOut();

          db.userName = null;

          Navigator.pushNamedAndRemoveUntil(
              context, '/', (Route<dynamic> route) => false);
              
          await signOutPopUp(context);
          
          
        } else if (value == 'Reset Data') {
          resetDataPopUp(context);
        } else if (value == 'Download Sheet') {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Downloading sheet...'),
              duration: Duration(seconds: 2),
            ),
          );
          await CreateCSV().getcsv(1);
          await CreateCSV().getcsv(2);
        } else
          restrictedPopUp(context);
      },
      icon: Icon(
        Icons.more_vert_rounded,
        color: Colors.white,
      ),
    );
  }

  restrictedPopUp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('This option is only for Admin!'),
        );
      },
    );
  }

  resetDataPopUp(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: FutureBuilder(
            future: db.initCollection(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return AlertDialog(
                  title: Text('Please wait while data is reseting....'),
                  content: Container(
                      height: 10.0,
                      child: Center(child: LinearProgressIndicator())),
                );
              else
                return AlertDialog(
                  title: Text('Data is reset succesfully!'),
                  actions: [
                    RaisedButton(
                      color: Colors.grey[850],
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                );
            },
          ),
        );
      },
    );
  }
}
