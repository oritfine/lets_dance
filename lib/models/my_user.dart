class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final int num;
  final List<String> videos_path;

  UserData(
      {required this.uid,
      required this.name,
      required this.num,
      required this.videos_path});
}
