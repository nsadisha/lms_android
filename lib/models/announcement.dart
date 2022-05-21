class Announcement {
  final int id;
  final String title;
  final String body;

  const Announcement({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      title: json['title'],
      body: json['description'],
    );
  }
}