import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auftrag_mobile/blocs/auth/authentication/authentication_bloc.dart';
import 'package:auftrag_mobile/blocs/auth/login/login_bloc.dart';
import 'package:auftrag_mobile/widgets/wave.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  bool isForgotPasswordEnabled(LoginState state) {
    return state.isEmailValid && _emailController.text.isNotEmpty;
  }

  bool _isPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  void _toggleVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocListener<LoginBloc, LoginState>(listener: (context, state) {
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    elevation: 6.0,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ungültige Anmeldeinformationen!'),
                          Icon(Icons.error)
                        ]),
                    backgroundColor: Colors.red),
              );
          }
          if (state.isPasswordResetFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    elevation: 6.0,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'error',
                          ),
                          Icon(Icons.error)
                        ]),
                    backgroundColor: Colors.red),
              );
          }
          if (state.isPasswordResetMailSent) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Die E-Mail zum Zurücksetzen des Passworts wurde an Ihre E-Mail-Adresse gesendet'),
                      Icon(Icons.check)
                    ],
                  ),
                  backgroundColor: Colors.red));
          }
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Color(0xFF5d74e3),
                  content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Einloggen...'),
                        CircularProgressIndicator()
                      ])));
          }
          if (state.isSuccess) {
            context.read<AuthenticationBloc>().add(AuthenticationLoggedIn());
          }
        }, child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                Container(
                  height: size.height - 350,
                  color: Color(0xFF47D5FE),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutQuad,
                  top: keyboardOpen ? -size.height / 3.7 : 0.0,
                  child: Wave(
                    size: size,
                    yOffset: size.height / 3.0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Auftrag',
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(
                                    color:
                                        /*Theme.of(context)
                                        .textSelectionTheme
                                        .cursorColor,*/
                                        Colors.black54,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    filled: true,
                                    focusColor: Theme.of(context).primaryColor,
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 2.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                    prefixIcon:
                                        Icon(Icons.mail, color: Colors.grey),
                                    hintText: 'Email'),
                                controller: _emailController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autocorrect: false,
                                validator: (_) {
                                  if (!state.isEmailValid) {
                                    return ('Ungültige E-Mail');
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.0),
                              TextFormField(
                                style: TextStyle(
                                    color:
                                        /*Theme.of(context)
                                        .textSelectionTheme
                                        .cursorColor*/
                                        Colors.black54,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    filled: true,
                                    focusColor: Theme.of(context).primaryColor,
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 2.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                    prefixIcon: Icon(Icons.lock_outline,
                                        color: Colors.grey),
                                    suffixIcon: IconButton(
                                        icon: _isPasswordHidden
                                            ? Icon(Icons.visibility_off,
                                                color: Colors.grey)
                                            : Icon(Icons.visibility,
                                                color: Colors.grey),
                                        onPressed: () {
                                          _toggleVisibility();
                                        }),
                                    hintText: 'Passwort'),
                                obscureText: _isPasswordHidden,
                                controller: _passwordController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autocorrect: false,
                                validator: (_) {
                                  if (!state.isPasswordValid) {
                                    return ('Ungültiges Passwort');
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50.0),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Material(
                            color: Theme.of(context).primaryColor,
                            child: InkWell(
                              onTap: isLoginButtonEnabled(state)
                                  ? _onFormSubmitted
                                  : null,
                              child: SizedBox(
                                height: 50.0,
                                width: size.width,
                                child: Center(
                                  child: Text(
                                    'Anmeldung',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        letterSpacing: 1.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Sie haben kein Konto?",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 16.0)),
                            SizedBox(width: 10.0),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text('Registrieren',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0)),
                            )
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/forgot-password');
                            },
                            child: Text('Passwort vergessen?',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0)),
                          ),
                        )
                      ]),
                )
              ],
            );
          },
        )));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }
}
