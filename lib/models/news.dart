
class News {
  int id;
  String title;
  String url;
  bool deleted;
  String by;
  bool dead;
  String type;
  int time;
  int comment;
  int score;

  News({this.id, this.title, this.url, this.deleted, this.by, this.dead, this.type, this.time, this.comment, this.score});

  factory News.fromJson(Map<String, dynamic> fromJson) {
    return News(
      id: fromJson['id'],
      title: fromJson['title'],
      url: fromJson['url'],
      deleted: fromJson['deleted'],
      by: fromJson['by'],
      dead: fromJson['dead'],
      type: fromJson['type'],
      time: fromJson['time'],
      comment: fromJson['descendants'],
      score: fromJson['score'],
    );
  }
  

}