class Diary {
  final String id;
  final String userId;
  final String title;
  final String content;
  final DateTime date;
  final DateTime createdAt;

  const Diary({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.date,
    required this.createdAt,
  });
}
