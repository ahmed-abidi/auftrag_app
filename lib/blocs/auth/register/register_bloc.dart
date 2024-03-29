import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:auftrag_mobile/models/auth.dart';
import 'package:auftrag_mobile/preferences/preferences.dart';
import 'package:auftrag_mobile/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is Submitted) {
      yield* _mapSubmittedToState(event);
    }
  }

  Stream<RegisterState> _mapSubmittedToState(Submitted event) async* {
    yield RegisterLoading();
    try {
      final Auth auth = await userRepository.register(
        event.name,
        event.username,
        event.email,
        event.password,
        event.passwordConfirmation,
      );
      storeUserData(auth.token, auth.userID, auth.name, auth.username);
      yield RegisterSuccess();
    } catch (e) {
      yield RegisterFailureMessage(errorMessage: e.message);
    }
  }

  void storeUserData(
      String token, int user_id, String name, String username) async {
    Prefer.prefs = await SharedPreferences.getInstance();
    Prefer.prefs.setString('token', token);
    Prefer.prefs.setInt('userID', user_id);
    Prefer.prefs.setString('name', name);
    Prefer.prefs.setString('username', username);
  }
}
