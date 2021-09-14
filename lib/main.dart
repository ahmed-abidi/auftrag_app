import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auftrag_mobile/blocs/auth/authentication/authentication_bloc.dart';
import 'package:auftrag_mobile/blocs/simple_bloc_observer.dart';
import 'package:auftrag_mobile/preferences/preferences.dart';
import 'package:auftrag_mobile/repositories/user_repository.dart';
import 'package:auftrag_mobile/ordery.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  int initialThemeIndex =
      WidgetsBinding.instance.window.platformBrightness == Brightness.light
          ? 0
          : 1;

  Prefer.prefs = await SharedPreferences.getInstance();
  Prefer.themeIndexPref = Prefer.prefs.getInt('theme') ?? initialThemeIndex;

  final UserRepository userRepository = UserRepository();

  runApp(
    BlocProvider(
        create: (context) => AuthenticationBloc(userRepository: userRepository)
          ..add(AuthenticationStarted()),
        child: Ordery(userRepository: userRepository)),
  );
}
