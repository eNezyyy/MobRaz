class Note {
  final int? id;
  String title;
  String content;
  DateTime dateCreated;
  DateTime dateUpdated;

  Note({
    this.id,
    required this.title,
    required this.content,
    DateTime? dateCreated,
    DateTime? dateUpdated,
  }) : 
    dateCreated = dateCreated ?? DateTime.now(),
    dateUpdated = dateUpdated ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'dateUpdated': dateUpdated.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      dateCreated: DateTime.fromMillisecondsSinceEpoch(map['dateCreated']),
      dateUpdated: DateTime.fromMillisecondsSinceEpoch(map['dateUpdated']),
    );
  }
}