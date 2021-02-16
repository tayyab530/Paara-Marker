import 'dart:async';

import 'package:flutter_firebase_practice/blocs/validators/eAndPvalidators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Object with EandPvalidatorsMixin{
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _userName = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeUserName => _userName.sink.add;

  Stream<bool> get submitForLog => Rx.combineLatest2(email, password,(a, b) => true);
  Stream<bool> get submitForReg => Rx.combineLatest3(email, password,userName , (a, b, c) => true);

  Stream<String> get email => _email.stream.transform(emailValidate());
  Stream<String> get password => _password.stream.transform(passwordValidate());
  Stream<String> get userName => _userName.stream.transform(userNameValidate());

  dispose(){
    _email.close();
    _password.close();
    _userName.close();
  }

  String getEmail() => _email.value;
  String getPassword() => _password.value;
  String getUserName() => _userName.value;
  
} 
