import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:auftrag_mobile/blocs/chat/chat_bloc.dart';
//import 'package:auftrag_mobile/repositories/chat_repository.dart';
import 'package:auftrag_mobile/screens/screens.dart';
import 'package:auftrag_mobile/theme/app_theme.dart';
import 'package:auftrag_mobile/theme/bloc/theme_bloc.dart';
import 'package:auftrag_mobile/repositories/repositories.dart';
import 'package:auftrag_mobile/blocs/blocs.dart';

import 'blocs/invoice/invoice_bloc.dart';

class Ordery extends StatefulWidget {
  final UserRepository userRepository;

  const Ordery({Key key, this.userRepository}) : super(key: key);

  @override
  _OrderyState createState() => _OrderyState();
}

class _OrderyState extends State<Ordery> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc =
        AuthenticationBloc(userRepository: widget.userRepository);
    _authenticationBloc.add(AuthenticationStarted());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(
            orderRepository: OrderRepository(),
          ),
        ),
        BlocProvider<AuthProfileBloc>(
          create: (context) =>
              AuthProfileBloc(userRepository: widget.userRepository),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) =>
              ProfileBloc(userRepository: widget.userRepository),
        ),
        BlocProvider<InvoiceBloc>(
          create: (context) =>
              InvoiceBloc(invoiceRepository: InvoiceRepository()),
        ),
        /*BlocProvider<MentionBloc>(
          create: (context) =>
              MentionBloc(userRepository: widget.userRepository),
        ),*/
      ],
      child: _buildWithTheme(context),
    );
  }

  Widget _buildWithTheme(BuildContext context) {
    return BlocBuilder<ThemeBloc, AppTheme>(
      builder: (context, appTheme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'auftrag',
          theme: appThemeData[appTheme],
          routes: {
            '/': (context) {
              return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state is AuthenticationFailure) {
                  return LoginScreen(userRepository: widget.userRepository);
                }
                if (state is AuthenticationSuccess) {
                  return HomeScreen();
                }
                return SplashScreen();
              });
            },
            '/register': (context) =>
                RegisterScreen(userRepository: widget.userRepository),
            '/profile': (context) => EditProfileScreen(),
            '/orderdetail': (context) => OrderdetailScreen(),
            '/orderfinish': (context) => OrderfinishScreen(),
            '/Einstellungen': (context) => SettingsScreen(),
            '/forgot-password': (context) => ForgotPasswordScreen(),
          },
        );
      },
    );
  }
}
