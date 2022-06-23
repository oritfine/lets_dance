class Video {
  final String video_id;
  final String user_id;
  final String name;
  final String url;
  final int likes;
  final List<dynamic> likers;

  Video({
    required this.video_id,
    required this.user_id,
    required this.name,
    required this.url,
    required this.likes,
    required this.likers,
  });
}
