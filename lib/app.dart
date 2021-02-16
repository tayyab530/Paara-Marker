import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/screens/para_tab.dart';
import 'package:flutter_firebase_practice/screens/registerScreen.dart';
import 'package:flutter_firebase_practice/widgets/authenticate.dart';
import 'screens/loginScreen.dart';
import 'package:flutter/cupertino.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        title: 'Paara Marker',
        debugShowCheckedModeBanner: false,
        home: Authenticate(),
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      if (settings.name == '/')
        return new App();
      else if (settings.name == '/log')
        return LoginScreen();
      else if (settings.name == '/tab')
        return TabsBar();
      else
        return RegiterationScreen();
    });
  }
}
