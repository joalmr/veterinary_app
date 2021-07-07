abstract class AuthInterface {
  Future<int> login(String email, String password);
  Future<int> logOut();
}