class Announcement {

  late int id;
  String title;
  String body;

  Announcement( this.title, this.body);
  
  Announcement.json({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement.json(
      id: json['id'],
      title: json['title'],
      body: json['description'],
    );
  }
}