import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auftrag_mobile/blocs/auth/register/register_bloc.dart';
import 'package:auftrag_mobile/screens/auth/register_images_form.dart';
import 'package:auftrag_mobile/blocs/auth/authentication/authentication_bloc.dart';
import 'package:auftrag_mobile/blocs/auth/register/register_bloc.dart';
import 'package:auftrag_mobile/utils/validators.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterBloc _registerBloc;

  bool isButtonEnabled(RegisterState state) {
    return state is! RegisterLoading;
  }

  bool _autovalidate = false;
  final passKey = GlobalKey<FormFieldState>();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  String _name;
  String _username;
  String _email;
  String _password;
  String _passwordConfirmation;

  @override
  void initState() {
    super.initState();
    _registerBloc = context.read<RegisterBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        //resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Theme.of(context).appBarTheme.iconTheme.color,
          ),
          title: Text(
            'Registrieren',
            style: Theme.of(context).appBarTheme.textTheme.caption,
          ),
          centerTitle: true,
        ),
        body: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
          if (state is RegisterFailureMessage) {
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
          if (state is RegisterLoading) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.black26,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Registrieren...',
                      ),
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              );
          }
          if (state is RegisterSuccess) {
            /*Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: _registerBloc,
                  child: RegisterImagesForm(),
                ),
              ),
            );*/
            Navigator.popUntil(context, ModalRoute.withName('/'));
            context.read<AuthenticationBloc>().add(AuthenticationLoggedIn());
          }
        }, child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(12.0),
              child: ListView(
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
                          'Name',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          style: TextStyle(
                              color: Colors.black54,
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
                            hintText: 'Name',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          validator: (val) {
                            return val.trim().isEmpty
                                ? 'Name darf nicht leer sein'
                                : null;
                          },
                          onSaved: (value) => _name = value,
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Nutzername',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            filled: true,
                            focusColor: Colors.white,
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
                            hintText: 'Nutzername',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          validator: (val) {
                            return val.trim().isEmpty
                                ? 'Der Benutzername darf nicht leer sein'
                                : null;
                          },
                          onSaved: (value) => _username = value,
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Email',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              filled: true,
                              focusColor: Colors.white,
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
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.grey,
                              ),
                              hintText: 'du@beispiel.com'),
                          validator: (val) {
                            return !Validators.isValidEmail(val)
                                ? 'Invalid email.'
                                : null;
                          },
                          onSaved: (value) => _email = value,
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Passwort eingeben',
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
                                  Icon(Icons.lock_outline, color: Colors.grey),
                              suffixIcon: IconButton(
                                color: Colors.grey,
                                icon: _isPasswordHidden
                                    ? Icon(
                                        Icons.visibility_off,
                                      )
                                    : Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordHidden = !_isPasswordHidden;
                                  });
                                },
                              ),
                              hintText: '********'),
                          obscureText: _isPasswordHidden,
                          validator: (val) {
                            return val.trim().isEmpty
                                ? 'Passwort kann nicht leer sein.'
                                : null;
                          },
                          onSaved: (value) => _password = value,
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Kennwort bestätigen',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          style: TextStyle(
                              color: Colors.black54,
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
                              prefixIcon: Icon(Icons.lock, color: Colors.grey),
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
                            } else if (val != passKey.currentState.value) {
                              return 'Passwortbestätigung stimmt nicht überein.';
                            } else
                              return null;
                          },
                          onSaved: (value) => _passwordConfirmation = value,
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
                        onTap: isButtonEnabled(state) ? _onFormSubmitted : null,
                        child: SizedBox(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              'Registrieren',
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
                ],
              ),
            );
          },
        )));
  }

  void _onFormSubmitted() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _registerBloc.add(
        Submitted(
          name: _name,
          username: _username,
          email: _email,
          password: _password,
          passwordConfirmation: _passwordConfirmation,
        ),
      );
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
}
