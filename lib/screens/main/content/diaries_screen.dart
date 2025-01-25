import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:not_today_client/models/data/dummy_data.dart';

class DiariesScreen extends StatefulWidget {
  const DiariesScreen({super.key});

  @override
  _DiariesScreenState createState() => _DiariesScreenState();
}

class _DiariesScreenState extends State<DiariesScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  // Method to format date to "dd/MM/yyyy"
  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Method to show the BottomSheet
  void _showAddDiaryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // To allow control of height
      backgroundColor: Colors
          .transparent, // Make the background transparent to use custom height
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height *
              0.75, // Set height to 75% of the screen
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
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Content Input Field
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              // Submit Button
              ElevatedButton(
                onPressed: _addDiary,
                child: const Text('Add Diary'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to add a diary entry
  void _addDiary() {
    final String title = _titleController.text;
    final String content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Diary added: $title')),
      );
      // Andre, aqui que depois se faz a mutation do add.
      _titleController.clear();
      _contentController.clear();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Diary"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDiaryBottomSheet(context),
          )
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
                      // On tap, show the full diary details or navigate to a different screen
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
