import 'package:app_movie/bloc/base_bloc.dart';
import 'package:app_movie/constants.dart';
import 'package:app_movie/main.dart';
import 'package:app_movie/service/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

typedef NavigatorScreen = void Function(dynamic value);

class LoginBloc extends BaseBloc {
  LoginBloc() {
    _isRegister?.sink?.add(false);
    _isLogin?.sink?.add(false);
  }

  final BehaviorSubject<String> _email = BehaviorSubject<String>();
  final BehaviorSubject<String> _password = BehaviorSubject<String>();
  final BehaviorSubject<bool> _isRegister = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _isLogin = BehaviorSubject<bool>();

  Stream<String> get email => _email?.stream;

  Stream<String> get password => _password?.stream;

  Stream<bool> get isRegister => _isRegister?.stream;

  Stream<bool> get isLogin => _isLogin?.stream;

  NavigatorScreen navigator;

  Future<void> getLogin() async {
    bool result =  await StoreData.read(KeyStore.LOGIN);
    navigator(result ?? false);
  }

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

  signUpEmailPassword() async {
    AuthResult result;
    result = await mAuth
        .createUserWithEmailAndPassword(
            email: _email?.value, password: _password?.value)
        .then((value) {
      StoreData.store(KeyStore.LOGIN, true);
      navigator(null);
    }).catchError((e) => navigator(e.toString()));
  }

  signInEmailPassword() async {
    AuthResult result;
    result = await mAuth
        .signInWithEmailAndPassword(
            email: _email?.value, password: _password?.value)
        .then((value) {
      navigator(null);
      StoreData.store(KeyStore.LOGIN, true);
    }).catchError((e) => navigator(e.toString()));
  }

  String getEmail() {
    return _email?.stream?.value;
  }

  @override
  void onDispose() {
    _email?.close();
    _password?.close();
    _isLogin?.close();
    _isRegister?.close();
  }
}
