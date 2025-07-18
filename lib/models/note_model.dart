class NoteModel {
  final String id;
  final String title;
  final String message;
  final String userId;
  final DateTime timestamp;

  NoteModel({
    required this.id,
    required this.title,
    required this.message,
    required this.userId,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'userId': userId,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map, String id) {
    return NoteModel(
      id: id,
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      userId: map['userId'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
  
}
