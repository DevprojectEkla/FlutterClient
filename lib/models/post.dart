class Author {
  final String username;
  final String? mail;

  Author({
    required this.username,
    required this.mail,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      username: json['username'],
      mail: json['email'],
    );
  }
}
class Post {
  final int id;
  final String title;
  final Author author;
  final DateTime dateCreated;
  final String content;

  Post({
    required this.id,
    required this.title,
    required this.author,
    required this.dateCreated,
    required this.content,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
      if (json == null){
              throw FormatException("Null JSON");
          }
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      author: Author.fromJson(json['author']),
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      content: json['content'] as String,
    );
  }
}
