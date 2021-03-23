import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/login_bloc.dart';
import 'package:app_movie/common/common.dart';
import 'package:app_movie/common/widgets/navigator_button.dart';
import 'package:app_movie/common/widgets/text_field_pass_word.dart';
import 'package:app_movie/screens/login/widgets/ic_button_login.dart';
import 'package:app_movie/screens/main/main_screen.dart';
import 'package:app_movie/screens/register/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routerName = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginBloc _loginBloc = LoginBloc();
  bool _visibilityPass = false;

  void onChange(bool visibility) {
    setState(() {
       _visibilityPass = visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc.navigator = navigator;
    print('----------------------->');
    return AppContainer(
      hidePadding: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 54, horizontal: 16),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 32.0,
              ),
              Image.asset('assets/images/logo.png', height: 84, width: 94,),
              const SizedBox(
                height: 44.0,
              ),
              StreamBuilder<String>(
                  stream: _loginBloc.email,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      onChanged: (String email) =>
                          _loginBloc.updateEmail(email),
                      decoration: InputDecoration(
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.white),
                    );
                  }),
              const SizedBox(
                height: 24.0,
              ),
              TextFieldPassword(
                loginBloc: _loginBloc,
              ),
              const SizedBox(
                height: 32.0,
              ),
              NavigatorButton(
                label: 'Login',
                onPressed: () => _loginBloc.signInEmailPassword()
              ),
              const SizedBox(
                height: 28.0,
              ),
              _buildLoginOr(),
              _buildIconLogin(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 40,
        child: RichText(
          text: TextSpan(
              text: 'You no account?',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              children: [TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = () {
                     Navigator.push(context, MaterialPageRoute(builder: (ctx) => RegisterScreen()));
                  },
                  text: ' Register now', style: TextStyle(color: Colors.black, fontSize: 12))]),
        ),
      ),
    );
  }

  ButtonBar _buildIconLogin() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: [
        IcButtonLogin(icon: 'assets/images/ic_google.png', onPressed: () {

        }),
        IcButtonLogin(icon: 'assets/images/apple.png', onPressed: () {

        }),
        IcButtonLogin(icon: 'assets/images/ic_fb.png', onPressed: () {

        }),
      ],
    );
  }

  Row _buildLoginOr() {
    return Row(
              children: [
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                    child: Container(
                  height: 1,
                  color: Colors.grey,
                )),
                const SizedBox(
                  width: 16,
                ),
                Text('or'),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Container(
                  height: 1,
                  color: Colors.grey,
                )),
                const SizedBox(
                  width: 24,
                ),
              ],
            );
  }

  @override
  void dispose() {
    _loginBloc?.onDispose();
    super.dispose();
  }

  void navigator(dynamic value) {
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
      Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext ctx) => MainScreen()));
    }
  }
}
