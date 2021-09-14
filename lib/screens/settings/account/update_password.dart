import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auftrag_mobile/blocs/auth_profile/auth_profile_bloc.dart';
import 'package:auftrag_mobile/widgets/loading_indicator.dart';

class UpdatePasswordScreen extends StatefulWidget {
  UpdatePasswordScreen({Key key}) : super(key: key);

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final passKey = GlobalKey<FormFieldState>();

  bool _autovalidate = false;

  String _oldPassword;
  String _password;
  String _confirmPassword;

  bool _isCurrentPasswordHidden = true;
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  bool isButtonEnabled(AuthProfileState state) {
    return !(state is AuthProfilePasswordUpdating);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: BackButton(
          color: Theme.of(context).appBarTheme.iconTheme.color,
        ),
        title: Text(
          'Passwort erneuern',
          style: Theme.of(context).appBarTheme.textTheme.caption,
        ),
        centerTitle: true,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
        ),
      ),
      body: BlocListener<AuthProfileBloc, AuthProfileState>(
        listener: (context, state) {
          if (state is AuthProfileErrorMessage) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.red,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.errorMessage,
                      ),
                    ],
                  ),
                ),
              );
          }

          if (state is AuthProfilePasswordUpdateSuccess) {
            context.read<AuthProfileBloc>().add(
                  FetchAuthProfile(),
                );
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<AuthProfileBloc, AuthProfileState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height,
                      child: Stack(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            autovalidateMode: _autovalidate
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'dein aktuelles Passwort',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                      filled: true,
                                      focusColor:
                                          Theme.of(context).primaryColor,
                                      enabledBorder: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          width: 2.0,
                                          color: Colors.red,
                                        ),
                                      ),
                                      prefixIcon: Icon(Icons.lock_outline,
                                          color: Colors.grey),
                                      suffixIcon: IconButton(
                                        color: Colors.grey,
                                        icon: _isCurrentPasswordHidden
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            _isCurrentPasswordHidden =
                                                !_isCurrentPasswordHidden;
                                          });
                                        },
                                      ),
                                      hintText: 'Jetziges Passwort'),
                                  obscureText: _isCurrentPasswordHidden,
                                  validator: (val) {
                                    return val.trim().isEmpty
                                        ? 'Aktuelles Passwort darf nicht leer sein.'
                                        : null;
                                  },
                                  onSaved: (value) => _oldPassword = value,
                                ),
                                SizedBox(height: 30.0),
                                Text(
                                  'Neues Passwort eingeben',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  key: passKey,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                      filled: true,
                                      focusColor:
                                          Theme.of(context).primaryColor,
                                      enabledBorder: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          width: 2.0,
                                          color: Colors.red,
                                        ),
                                      ),
                                      prefixIcon: Icon(Icons.lock_outline,
                                          color: Colors.grey),
                                      suffixIcon: IconButton(
                                        color: Colors.grey,
                                        icon: _isPasswordHidden
                                            ? Icon(
                                                Icons.visibility_off,
                                              )
                                            : Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordHidden =
                                                !_isPasswordHidden;
                                          });
                                        },
                                      ),
                                      hintText: 'Neues Passwort'),
                                  obscureText: _isPasswordHidden,
                                  validator: (val) {
                                    return val.trim().isEmpty
                                        ? 'Passwort kann nicht leer sein.'
                                        : null;
                                  },
                                  onSaved: (value) => _password = value,
                                ),
                                SizedBox(height: 30.0),
                                Text(
                                  'Bestätige neues Passwort',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                      filled: true,
                                      focusColor:
                                          Theme.of(context).primaryColor,
                                      enabledBorder: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          width: 2.0,
                                          color: Colors.red,
                                        ),
                                      ),
                                      prefixIcon:
                                          Icon(Icons.lock, color: Colors.grey),
                                      suffixIcon: IconButton(
                                        color: Colors.grey,
                                        icon: _isConfirmPasswordHidden
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            _isConfirmPasswordHidden =
                                                !_isConfirmPasswordHidden;
                                          });
                                        },
                                      ),
                                      hintText: 'Passwort Bestätigung'),
                                  obscureText: _isConfirmPasswordHidden,
                                  validator: (val) {
                                    if (val.trim().isEmpty) {
                                      return 'Passwortbestätigung darf nicht leer sein';
                                    } else if (val !=
                                        passKey.currentState.value) {
                                      return 'Passwortbestätigung stimmt nicht überein.';
                                    } else
                                      return null;
                                  },
                                  onSaved: (value) => _confirmPassword = value,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.0),
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOutQuad,
                            bottom: keyboardOpen ? size.height * 0.52 : 100.0,
                            child: InkWell(
                              onTap: isButtonEnabled(state)
                                  ? _onFormSubmitted
                                  : null,
                              child: Container(
                                width: size.width * 0.94,
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: (state is AuthProfilePasswordUpdating)
                                    ? LoadingIndicator(
                                        color: Colors.white,
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Aktualisieren',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                letterSpacing: 1.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 20.0),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onFormSubmitted() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      context.read<AuthProfileBloc>().add(
            UpdateAuthProfilePassword(
                oldPassword: _oldPassword,
                newPassword: _password,
                newPasswordConfirmation: _confirmPassword),
          );
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
}
