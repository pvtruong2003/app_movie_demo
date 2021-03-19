import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/login_bloc.dart';
import 'package:app_movie/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      hidePadding: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 64.0,),
              Image.asset('assets/images/logo.png'),
              const SizedBox(height: 32.0,),
              StreamBuilder<String>(
                stream: _loginBloc.email,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return TextField(
                    onChanged: (String email) => _loginBloc.updateEmail(email),
                    decoration: InputDecoration(
                       errorText: snapshot.hasError ? snapshot.error.toString() : null,
                        hintText: 'Email', filled: true, fillColor: Colors.white),
                  );
                }
              ),
              const SizedBox(height: 12.0,),

              StreamBuilder<String>(
                  stream: _loginBloc.password,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      onChanged: (String pass) => _loginBloc.updatePass(pass),
                      decoration: InputDecoration(
                          errorText: snapshot.hasError ? snapshot.error.toString() : null,
                          hintText: 'Password', filled: true, fillColor: Colors.white),
                    );
                  }
              ),
              const SizedBox(height: 32.0,),

              MaterialButton(onPressed: () {
                     Navigator.pushReplacement(context, MaterialPageRoute<void>(builder: (BuildContext ctx) => MainScreen()));
               },
                minWidth: double.infinity,
               color: Colors.cyan,
               child: const Text('Login', style: TextStyle(color: Colors.white),),)

            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc?.onDispose();
    super.dispose();
  }
}
