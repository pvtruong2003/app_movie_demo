import 'package:app_movie/bloc/base_bloc.dart';
import 'package:app_movie/constants.dart';
import 'package:app_movie/main.dart';
import 'package:app_movie/service/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    bool result =  await StoreData.read(KeyStore.login);
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
      StoreData.store(KeyStore.login, true);
      StoreData.storeUUID(KeyStore.uuid, value.user.uid);
      addUser(value.user);
    }).catchError((e) => navigator(e.toString()));
  }

  Future<void> addUser(FirebaseUser user) async {
    await Firestore.instance.collection("users").add({
      'email': user.email,
      'uuid': user.uid,
      'firstName': '',
      'lastName': ''
    }).then((value) => navigator(null));
  }

  signInEmailPassword() async {
    AuthResult result;
    result = await mAuth
        .signInWithEmailAndPassword(
            email: _email?.value, password: _password?.value)
        .then((value) {
      navigator(null);
      StoreData.store(KeyStore.login, true);
      StoreData.storeUUID(KeyStore.uuid, value.user.uid);
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
