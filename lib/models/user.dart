class UserModel {
  final String uid;
  final String name;
  final int num;
  final List<dynamic> videos;

  UserModel(
      {required this.uid,
      required this.name,
      required this.num,
      required this.videos});
}
