import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/login_bloc.dart';
import 'package:app_movie/common/common.dart';
import 'package:app_movie/common/widgets/navigator_button.dart';
import 'package:app_movie/common/widgets/text_field_pass_word.dart';
import 'package:app_movie/screens/login/login_screen.dart';
import 'package:app_movie/screens/main/main_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    _loginBloc.navigator = navigator;
    return AppContainer(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,

      ),
      hidePadding: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/logo.png', height: 84, width: 94,),
              const SizedBox(height: 36.0,),
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
              const SizedBox(height: 16.0,),
              TextFieldPassword(
                loginBloc: _loginBloc,
              ),
              const SizedBox(height: 32.0,),
              NavigatorButton(
                  label: 'Register',
                  onPressed: () => _loginBloc.signUpEmailPassword()),
              const SizedBox(height: 24.0,),
              RichText(
                text: TextSpan(
                    text: 'Do you an account?',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    children: [TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routerName, (route) => false),
                        text: ' Login now', style: TextStyle(color: Colors.black, fontSize: 12))]),
              )

            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async{
    await _loginBloc.signUpEmailPassword();
  }

  @override
  void dispose() {
    _loginBloc?.onDispose();
    super.dispose();
  }

  navigator(dynamic value) {
    Common.hideLoading(context);
    if (value != null) {
      showDialog<void>(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(value),
            );
          },
          useSafeArea: true);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.routerName, (route) => false);
    }
  }
}
