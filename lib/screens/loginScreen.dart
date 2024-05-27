import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/blocs/LoginBloc.dart';
import 'package:flutter_firebase_practice/errorsHandlers/LAndR_errorHandler.dart';
import '../services/auth.dart';

class LoginScreen extends StatelessWidget {
  final bloc = LoginBloc();
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[800],
          title: Text('Login Screen',style: TextStyle(color: Colors.white),),
          leading: BackButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            color: Colors.white,
          ),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
            ),
            emailField(bloc),
            Container(
              margin: EdgeInsets.all(10.0),
            ),
            passwordField(bloc),
            Container(
              margin: EdgeInsets.all(10.0),
            ),
            submitButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget emailField(LoginBloc bloc) {
    return StreamBuilder(
        initialData: 'asd@asd.com',
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
                errorText: snapshot.hasError ? snapshot.error.toString() : '',
                errorStyle: TextStyle(color: Colors.blueGrey),
              ),
              onChanged: bloc.changeEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(15.0),
              // border: Border.all(
              //   width: 2.0,
              //   color: Colors.black,
              // ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          );
        });
  }

  Widget passwordField(LoginBloc bloc) {
    return StreamBuilder(
        initialData: 'asdasd',
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
                errorText: snapshot.hasError ? snapshot.error.toString() : '',
                errorStyle: TextStyle(color: Colors.blueGrey),
              ),
              onChanged: bloc.changePassword,
            ),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(15.0),
              // border: Border.all(
              //   width: 1.5,
              //   color: Colors.black,
              // ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          );
        });
  }

  Widget submitButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.submitForLog,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 80.0),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(10.0),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey.withOpacity(0.5),
          //       spreadRadius: 2,
          //       blurRadius: 3,
          //       offset: Offset(0, 3), // changes position of shadow
          //     ),
          //   ],
          // ),
          child: ElevatedButton(
            // borderRadius: BorderRadius.circular(10.0),
            // color: Colors.grey[700],
            // disabledColor: Colors.grey.shade400,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              backgroundColor: Colors.grey[700],
              disabledBackgroundColor: Colors.grey.shade400,
            ),
            child: Text('Login',style: TextStyle(color: Colors.white),),
            onPressed: !snapshot.hasData
                ? null
                : () async {
                    auth.user = await auth.loginWithEandP(
                        bloc.getEmail(), bloc.getPassword());
                    if (auth.user == null) {
                      loginErrorPopUp(context, auth.getError());
                    } else {
                      await delayProgress(context, 'Loged in', 1);
                      Navigator.pushNamed(context, '/tab');
                      print('${auth.getCurrentUserId()}');
                    }
                  },
          ),
        );
      },
    );
  }
}
