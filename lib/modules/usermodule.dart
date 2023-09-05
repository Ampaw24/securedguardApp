class UserModule {
  String profile_url;
  String userName;

  String userId;
  String email;
  String gender;
  int age;

  UserModule(
      {
      required this.email,
      required this.profile_url,
      required this.userId,
      required this.userName,
      required this.gender,
      required this.age});
}
