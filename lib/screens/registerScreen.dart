import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/errorsHandlers/LAndR_errorHandler.dart';
import 'package:flutter_firebase_practice/services/Db_firestore.dart';
import '../blocs/LoginBloc.dart';
import '../services/auth.dart';

class RegiterationScreen extends StatelessWidget {
  final bloc = LoginBloc();
  final DbProvider db = DbProvider();

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()async=> false,
          child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,

          backgroundColor: Colors.grey[800],
          title: Text('Registeration Screen'),
          leading: BackButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ),
        body: ListView(
          children: [
            Container(margin: EdgeInsets.all(10.0)),
            userNameField(bloc),
            Container(margin: EdgeInsets.all(10.0)),
            emailField(bloc),
            Container(margin: EdgeInsets.all(10.0)),
            passwordField(bloc),
            Container(margin: EdgeInsets.all(10.0)),
            submitButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget emailField(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.email,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Email Address',
                hintText: 'you@example.com',
                errorText: snapshot.hasError ? snapshot.error : '',
                errorStyle: TextStyle(color: Colors.blueGrey),
              ),
              onChanged: bloc.changeEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(40.0),
              // border: Border.all(
              //   width: 2.0,
              //   color: Colors.black,
              // ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          );
        });
  }

  Widget userNameField(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.userName,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'User Name',
                hintText: 'e.g. Fahad',
                errorText: snapshot.hasError ? snapshot.error : '',
                errorStyle: TextStyle(color: Colors.blueGrey),
              ),
              onChanged: bloc.changeUserName,
            ),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(40.0),
              // border: Border.all(
              //   width: 2.0,
              //   color: Colors.black,
              // ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          );
        });
  }

  Widget passwordField(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.password,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Password',
                hintText: '*****',
                errorText: snapshot.hasError ? snapshot.error : '',
                errorStyle: TextStyle(color: Colors.blueGrey),
              ),
              onChanged: bloc.changePassword,
            ),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(40.0),
              // border: Border.all(
              //   width: 2.0,
              //   color: Colors.black,
              // ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          );
        });
  }

  Widget submitButton(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.submitForReg,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return Container(
             margin: EdgeInsets.symmetric(horizontal: 80.0),
             decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: CupertinoButton(
              borderRadius: BorderRadius.circular(30.0),
             color: Colors.grey[700],
              child: Text('Register'),
              onPressed: !snapshot.hasData
                  ? null
                  : () async {
                      auth.user = await auth.registerWithEandP(
                          bloc.getEmail(), bloc.getPassword());
                      if (auth.user == null) {
                        regErrorPopUp(context, auth.getError());
                      } else {
                        db.addUserName(bloc.getUserName(),auth.getCurrentUserId());
                        await delayProgress(context, 'Registered' , 1);
                        Navigator.pushNamed(context, '/tab');
                      }
                    },
            ),
          );
        });
  }
}
