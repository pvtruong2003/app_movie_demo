import 'package:app_movie/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc  {
  final BehaviorSubject<String> _email = BehaviorSubject<String>();
  final BehaviorSubject<String> _password = BehaviorSubject<String>();
  
  Stream<String> get email => _email?.stream;
  Stream<String> get password => _password?.stream;
  
  void updateEmail(String email) {
    if (email == null || email == '') {
      _email?.sink?.addError('Invalid value entered!');
    } else {
      _email?.sink?.add(email);
    }
  }
  void updatePass(String password) {
    if (password == null || password == '') {
      _password?.sink?.addError('Invalid value entered!');
    } else {
      _password?.sink?.add(password);
    }
  }

  String getEmail() {
    return _email?.stream?.value;
  }

  @override
  void onDispose() {
    _email?.close();
    _password?.close();
  }
}