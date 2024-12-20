import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:auftrag_mobile/constants/api_constants.dart';
import 'package:auftrag_mobile/models/auth.dart';
import 'package:auftrag_mobile/models/user.dart';
import 'package:auftrag_mobile/preferences/preferences.dart';
import 'package:http_parser/http_parser.dart';

class UserApiClient {
  static const baseUrl = ApiConstants.BASE_URL;
  static final userName = Prefer.prefs.getString('userName');
  final http.Client httpClient;

  UserApiClient({http.Client httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<Auth> login({String email, String password}) async {
    final loginUrl = '$baseUrl/login';
    final loginResponse = await this.httpClient.post(
          Uri.parse(loginUrl),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
          },
          body: jsonEncode(
            <String, String>{
              'email': email,
              'password': password,
            },
          ),
        );
    print(loginResponse.statusCode);
    if (loginResponse.statusCode != 200) {
      throw Exception('Invalid Credentials');
    }

    final loginJson = jsonDecode(loginResponse.body);
    print(loginJson);
    return Auth.fromJson(loginJson);
  }

  Future<void> logout(String token) async {
    final logoutUrl = '$baseUrl/logout';

    final logoutResponse = await this.httpClient.post(
      Uri.parse(logoutUrl),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    print(logoutResponse.statusCode);
    if (logoutResponse.statusCode != 200) {
      throw Exception('Invalid Credentials');
    }
  }

  Future<Auth> register(
      {String name,
      String username,
      String email,
      String password,
      String passwordConfirmation}) async {
    final url = '$baseUrl/register';

    final response = await this.httpClient.post(
          Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
          },
          body: jsonEncode(
            <String, String>{
              'name': name,
              'username': username,
              'email': email,
              'password': password,
              'password_confirmation': passwordConfirmation
            },
          ),
        );
    if (response.statusCode == 422) {
      var errorJson = jsonDecode(response.body)['errors'];
      print(errorJson);
      if (errorJson['email'] != null) {
        throw Exception(errorJson['email'][0]);
      } else if (errorJson['password_confirmation'] != null) {
        throw Exception(errorJson['password_confirmation'][0]);
      } else if (errorJson['user_name'] != null) {
        throw Exception(errorJson['user_name'][0]);
      } else
        throw Exception('Fehler beim Registrieren des Kontos');
    } else if (response.statusCode != 201) {
      throw Exception('Fehler beim Registrieren des Kontos');
    }

    final authJson = jsonDecode(response.body);

    return Auth.fromJson(authJson);
  }

  Future<User> fetchAuthInfo() async {
    final url = '$baseUrl/profile';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );
    if (response.statusCode != 200) {
      throw Exception('Error fetching profile.');
    }

    final userJson = jsonDecode(response.body)['data'];

    return User.fromJson(userJson);
  }

  Future<User> fetchUserInfo(String username) async {
    final authUsername = Prefer.prefs.getInt('userID');
    final url = '$baseUrl/profile/$authUsername ';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );
    if (response.statusCode != 200) {
      throw Exception('Error fetching profile.');
    }
    print(response.body);
    final userJson = jsonDecode(response.body)['data'];
    //print('authUsername:' + $authUsername);
    print('fetch user info:' + userJson);

    return User.fromJson(userJson);
  }

  Future<User> editProfile({String name, String username}) async {
    final authUsername = Prefer.prefs.getInt('userID');

    final token = Prefer.prefs.getString('token');

    final url = '$baseUrl/profile1';

    final response = await this.httpClient.patch(
          Uri.parse(url),
          headers: requestHeaders(token),
          body: jsonEncode(
            <String, String>{
              'first_name': name,
              'last_name': username,
            },
          ),
        );

    print(response.statusCode);

    if (response.statusCode == 422) {
      var errorJson = jsonDecode(response.body)['errors'];

      if (errorJson['username'] != null) {
        throw Exception('Benutzername bereits vergeben.');
      }
    } else if (response.statusCode != 201) {
      throw Exception('Fehler beim Aktualisieren des Profils!');
    }
    return User.fromJson(jsonDecode(response.body)['data']);
  }

  Future<String> updatePassword(
      {String oldPassword,
      String newPassword,
      String newPasswordConfirmation}) async {
    final url = '$baseUrl/auth/password';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.patch(
          Uri.parse(url),
          headers: requestHeaders(token),
          body: jsonEncode(
            <String, String>{
              'old_password': oldPassword,
              'new_password': newPassword,
              'new_password_confirmation': newPasswordConfirmation,
            },
          ),
        );
    if (response.statusCode == 422) {
      var errorJson = jsonDecode(response.body)['errors'];

      if (errorJson['old_password'] != null) {
        throw Exception('Das angegebene Passwort war falsch.');
      } else if (errorJson['new_password'] != null) {
        throw Exception(errorJson['new_password'][0]);
      } else if (errorJson['new_password_confirmation'] != null) {
        throw Exception(errorJson['new_password_confirmation'][0]);
      }
    } else if (response.statusCode != 200) {
      throw Exception('Fehler beim Aktualisieren des Passworts!');
    }
    return jsonDecode(response.body)['data'];
  }

  Future<User> updateEmail({String password, String email}) async {
    final url = '$baseUrl/auth/email';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.patch(
          Uri.parse(url),
          headers: requestHeaders(token),
          body: jsonEncode(
            <String, String>{
              'password': password,
              'email': email,
            },
          ),
        );
    if (response.statusCode == 422) {
      var errorJson = jsonDecode(response.body)['errors'];

      if (errorJson['password'] != null) {
        throw Exception('Das angegebene Passwort war falsch.');
      } else if (errorJson['password'] != null) {
        throw Exception(errorJson['password'][0]);
      }
    } else if (response.statusCode != 200) {
      var responseJson = jsonDecode(response.body);
      print(responseJson);

      throw Exception('Fehler beim Aktualisieren der E-Mail!');
    }

    return User.fromJson(jsonDecode(response.body)['data']);
  }

  Future<void> requestPasswordResetInfo(String email) async {
    final url = '$baseUrl/password/forgot';

    final response = await this.httpClient.post(
          Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
          },
          body: jsonEncode(
            <String, String>{
              'email': email,
            },
          ),
        );

    if (response.statusCode == 422) {
      var errorMessage = jsonDecode(response.body)['message'];
      throw Exception(errorMessage);
    } else if (response.statusCode != 200) {
      throw Exception(
          'Informationen zum Zurücksetzen des Passworts können nicht gesendet werden!');
    }
    return;
  }

  prepareResquest(String name, String username, String url, String s) {}

  /*Future<String> getAvatar() async {
    final url = '$baseUrl/profile/avatar';

    final token = Prefer.prefs.getString('token');

    final response = await this
        .httpClient
        .get(Uri.parse(url), headers: requestHeaders(token));
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('Invalid Credentials');
    }

    final avatar = jsonDecode(response.body)['data']['avatar'] as String;
    return avatar;
  }

  Future<List<User>> explore() async {
    final url = '$baseUrl/explore';

    final token = Prefer.prefs.getString('token');

    final response = await this
        .httpClient
        .get(Uri.parse(url), headers: requestHeaders(token));

    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('Error getting response');
    }

    final usersJson = jsonDecode(response.body)['data'] as List;

    return usersJson.map((user) => User.fromJson(user)).toList();
  }

  Future<MultipartRequest> prepareResquest(
      String name,
      String username,
      String description,
      File avatar,
      File banner,
      String url,
      String method) async {
    final request = http.MultipartRequest('POST', Uri.parse(url));
    if (method == 'PATCH') {
      request.fields['_method'] = 'PATCH';
    }

    request.fields['name'] = name;
    request.fields['username'] = username;
    request.fields['description'] = description;

    if (avatar != null) {
      var stream = new http.ByteStream(Stream.castFrom(avatar.openRead()));
      var length = await avatar.length();
      var multipartFile = new MultipartFile("avatar", stream, length,
          filename: basename(avatar.path),
          contentType: MediaType('multipart', 'form-data'));
      request.files.add(multipartFile);
    }

    if (banner != null) {
      var stream = new http.ByteStream(Stream.castFrom(banner.openRead()));
      var length = await banner.length();
      var multipartFile = new MultipartFile("banner", stream, length,
          filename: basename(banner.path),
          contentType: MediaType('multipart', 'form-data'));
      request.files.add(multipartFile);
    }

    return request;
  }

  Future<List<User>> findMentionedUser(String query) async {
    final url = '$baseUrl/mention?q=$query';

    final token = Prefer.prefs.getString('token');

    final response = await this
        .httpClient
        .get(Uri.parse(url), headers: requestHeaders(token));

    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('Error getting users');
    }

    final usersJson = jsonDecode(response.body) as List;

    return usersJson.map((user) => User.fromJson(user)).toList();
  }

  Future<void> uploadImages({File avatar, File banner}) async {
    final token = Prefer.prefs.getString('token');

    final url = '$baseUrl/profile-images';

    final request = http.MultipartRequest('POST', Uri.parse(url));

    if (avatar != null) {
      var stream = new http.ByteStream(Stream.castFrom(avatar.openRead()));
      var length = await avatar.length();
      var multipartFile = new MultipartFile("avatar", stream, length,
          filename: basename(avatar.path),
          contentType: MediaType('multipart', 'form-data'));
      request.files.add(multipartFile);
    }

    if (banner != null) {
      var stream = new http.ByteStream(Stream.castFrom(banner.openRead()));
      var length = await banner.length();
      var multipartFile = new MultipartFile("banner", stream, length,
          filename: basename(banner.path),
          contentType: MediaType('multipart', 'form-data'));
      request.files.add(multipartFile);
    }

    Map<String, String> _headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    request.headers.addAll(_headers);
    final response = await request.send();

    var _response = await http.Response.fromStream(response);
    if (response.statusCode != 204) {
      print(_response.body);
      throw Exception('Error uploading images!');
    }
    return;
  }*/
}
