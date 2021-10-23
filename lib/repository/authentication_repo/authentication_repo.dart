import 'package:zurichat/services/core_services/api_service.dart';
import 'package:zurichat/utilities/constants/app_constants.dart';

import 'i_authentication_repo.dart';

class AuthenticationRepo extends IAuthenticationRepo {
  final ApiService _service = ApiService();

  @override
  Future<dynamic> login(
      {required String email, required String password, token}) async {
    final headers = {'Authorization': 'Bearer $token'};
    return await _service.post("${coreBaseUrl}auth/login",
        body: {
          "email": email,
          "password": password,
        },
        headers: headers);
  }

  @override
  Future<dynamic> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String displayName,
      required String phoneNumber,
      required String token}) async {
    return await _service.post(
      "$coreBaseUrl/users",
      body: {
        'first_name': firstName,
        'last_name': lastName,
        'display_name': displayName,
        'email': email,
        'password': password,
        'phone': phoneNumber,
      },
    );
  }
}
