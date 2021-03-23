import 'package:app_movie/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  final LoginBloc loginBloc;
  final Function(bool visibility) visibilityPass;

  const TextFieldPassword({Key key, this.loginBloc, this.visibilityPass}) : super(key: key);

  @override
  _TextFieldPasswordState createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  bool visibilityPass = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: widget.loginBloc.password,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return TextField(
            obscureText: visibilityPass,
            maxLength: 20,
            onChanged: (String pass) => widget.loginBloc.updatePass(pass),
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                         visibilityPass = !visibilityPass;
                      });
                    },
                    child: Icon(
                      visibilityPass ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    )),
                errorText:
                snapshot.hasError ? snapshot.error.toString() : null,
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white),
          );
        });
  }
}

class PassWord extends InheritedWidget {

  PassWord({Key key, this.visibilityPass = false, @required Widget child}): super(key: key, child: child);


  final bool visibilityPass;

  @override
  bool updateShouldNotify(covariant PassWord oldWidget) {
      return oldWidget.visibilityPass != visibilityPass;
  }

  static PassWord of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PassWord>();
  }

}
