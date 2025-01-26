import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:not_today_client/providers/diary_provider.dart';
import 'package:not_today_client/providers/user_provider.dart';

class DiariesScreen extends ConsumerWidget {
  const DiariesScreen({super.key});

  // Method to format date to "dd/MM/yyyy"
  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Method to show the BottomSheet
  void _showAddDiaryBottomSheet(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // To allow control of height

      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title Input Field
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Content Input Field
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  final title = titleController.text.trim();
                  final content = contentController.text.trim();

                  if (title.isNotEmpty && content.isNotEmpty) {
                    ref.read(diaryProvider.notifier).addDiary(
                          'user_001',
                          title,
                          content,
                        );
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all fields.'),
                      ),
                    );
                  }
                },
                child: const Text('Add Diary'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedInUser = ref.watch(userProvider);
    final diaries = loggedInUser != null
        ? ref
            .watch(diaryProvider.notifier)
            .getLoggedInUserDiaries(loggedInUser.id)
        : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Diary"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDiaryBottomSheet(context, ref),
          ),
        ],
      ),
      body: diaries.isEmpty
          ? const Center(child: Text("No diaries yet"))
          : ListView.builder(
              itemCount: diaries.length,
              itemBuilder: (context, index) {
                final diary = diaries[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(diary.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          diary.content.length > 30
                              ? '${diary.content.substring(0, 30)}...'
                              : diary.content,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formatDate(diary.date),
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    onTap: () {
                      // On tap, show the full diary details
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(diary.title),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(diary.content),
                                  const SizedBox(height: 10),
                                  Text('Date: ${formatDate(diary.date)}'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
