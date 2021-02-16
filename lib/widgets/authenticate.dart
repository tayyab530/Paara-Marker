import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/screens/mainScreen.dart';
import 'package:flutter_firebase_practice/screens/para_tab.dart';
import 'package:flutter_firebase_practice/services/auth.dart';

class Authenticate extends StatelessWidget {

  Widget build(BuildContext context) {
    
    return auth.isLogedIn() != null ? TabsBar(): MainScreen();
  }
}