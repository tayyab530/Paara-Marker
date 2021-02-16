import 'dart:async';

import 'package:rxdart/rxdart.dart';

class CheckBoxBloc{
  final _checkBox = BehaviorSubject<bool>();

  Stream<bool> get checkBoxStream => _checkBox.stream.transform(_transformer);

  Function(bool) get changeState => _checkBox.sink.add;

  final _transformer = StreamTransformer<bool,bool>.fromHandlers(
    handleData: (value,sink)=> sink.add(value)
  );

  bool getValue() => _checkBox.value;

    dispose(){
      _checkBox.close();
    }
}
