class DiaryModel {
  final String? id;
  final String userId;
  final String title;
  final String content;
  final DateTime date;
  final DateTime? createdAt;

  DiaryModel({
    this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.date,
    this.createdAt,
  });

  static DiaryModel fromMap({required Map map}) {
    final id = map['id'] as String? ?? '';
    final userId = map['userId'] as String? ?? '';
    final title = map['title'] as String? ?? '';
    final content = map['content'] as String? ?? '';

    // Convert the date field safely
    final dateTimestamp =
        map['date'] as String? ?? ''; // Assuming it's a string
    DateTime? date;
    if (dateTimestamp.isNotEmpty) {
      // Convert the string to an int and then to DateTime
      final intDate = int.tryParse(dateTimestamp);
      if (intDate != null) {
        date = DateTime.fromMillisecondsSinceEpoch(intDate);
      }
    }

    return DiaryModel(
      id: id,
      userId: userId,
      title: title,
      content: content,
      date: date ?? DateTime.now(),
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
    );
  }
}
