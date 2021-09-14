import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String token;
  final int userID;
  final String name;
  final String username;

  const Auth({this.userID, this.name, this.username, this.token});

  @override
  List<Object> get props => [
        token,
        userID,
        name,
        username,
      ];

  // String get name => null;

  static Auth fromJson(dynamic json) {
    final authData = json['data'];
    return Auth(
      token: authData['token'] as String,
      userID: authData['user_id'] as int,
      name: authData['name'] as String,
      username: authData['username'] as String,
    );
  }
}
