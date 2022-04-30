class Musics {
  //late is a promise to dart that value will definitely be passed but at a later stage
  late String title;
  late String image;
  late String singer;
  late String url;

  Musics(
      {required this.title,
      required this.singer,
      required this.url,
      required this.image});
}
