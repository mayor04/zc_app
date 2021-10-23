abstract class IAuthenticationRepo{
    // LOGIN SERVICE
  Future<dynamic> login(
      {required String email, required String password, token});

        // SIGNUP SERVICE
  Future<dynamic> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String displayName,
      required String phoneNumber,
      required String token});
}