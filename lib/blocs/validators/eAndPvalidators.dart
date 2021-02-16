import 'dart:async';

class EandPvalidatorsMixin{

  emailValidate(){
    return StreamTransformer<String ,String>.fromHandlers(
      handleData: (String value,sink){

        if(value.contains('@') && value.contains('.') && value.contains('c') && value.contains('o') && value.contains('m'))
          sink.add(value);
        else
          sink.addError('Please Enter a valid email!');

      }
    );  
    
  }

  userNameValidate(){
    return StreamTransformer<String , String >.fromHandlers(
      handleData: (String value,sink){
        if(value.length > 5)
          sink.add(value);
        else
          sink.addError('User name is too short!');
      }
    );
  }

  passwordValidate(){
    return StreamTransformer<String , String >.fromHandlers(
      handleData: (String value,sink){
        if(value.length > 5)
          sink.add(value);
        else
          sink.addError('Please Enter at least 6 characters!');
      }
    );
  }

}