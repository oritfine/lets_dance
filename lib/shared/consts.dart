String upload_and_process_url =
    'https://ee13-82-166-29-42.eu.ngrok.io/upload_and_process';
String get_video_url = 'https://ee13-82-166-29-42.eu.ngrok.io/get_video?url=';
String choose_background_text = 'Choose a background for your video:';
String choose_avatar_text = 'Choose an avatar for your video:';
String choose_emoji_text = 'Choose an emoji for your avatar:';
String generate_text = 'Generating your Lets-Dance video';
List<String> video_fields = [
  'likers',
  'likes',
  'name',
  'url',
  'user_id',
  'video_id'
];
List<String> avatarNames = [
  'Green',
  'Pink-Lightblue-Yellow',
  'Green-Pink-Red',
  'Purple-Blue'
];

List<String> avatarNamesToSend = [
  'green',
  'pink_light_blue_yellow',
  'green_purple',
  'purple_pink_yellow'
];

List<String> facesNames = [
  'Default',
  'Angle',
  'Bazz',
  'Beast',
  'Belle',
  'Boy',
  'Cinderella',
  'Crazy',
  'Crying',
  'Elsa',
  'Flower-Girl',
  'Girl',
  'Glasses',
  'Kiss',
  'Laugh',
  'Laugh-2',
  'MiniMouse',
  'Nerd',
  'NerdGirl',
  'Piggi',
  'Red-Angry',
  'Shocking',
  'Simba',
  'Star-Wars',
  'Stitch',
  'Sun',
  'Tinkerbell',
  'Unicorn-Poop',
  'Winking-Girl'
];

String get_image_path(String type, String imageName) {
  if (type == 'background') {
    return 'images/background_images/$imageName.jpg';
  }
  if (type == 'avatar') {
    return 'images/avatars/$imageName.png';
  }
  if (type == 'emoji') {
    return 'images/faces/$imageName.png';
  } else {
    return 'images/$imageName.png';
  }
}
