import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:not_today_client/providers/diary_provider.dart';
import 'package:not_today_client/providers/user_provider.dart';
import 'package:not_today_client/graphql/graphql_service.dart';

class DiariesScreen extends ConsumerStatefulWidget {
  const DiariesScreen({super.key});

  @override
  DiariesScreenState createState() => DiariesScreenState();
}

class DiariesScreenState extends ConsumerState<DiariesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String? _titleError;
  String? _contentError;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    final loggedInUser = ref.read(userProvider);
    if (loggedInUser != null) {
      ref
          .read(diaryProvider.notifier)
          .fetchDiaries("678938ae4568454eb72369f2"); // loggedInUser.id
    }
  }

  // Show Add Diary Bottom Sheet
  void _showAddDiaryBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title Input Field
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    errorText: _titleError,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Content Input Field
                TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    errorText: _contentError,
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Content is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Submit Button
                ElevatedButton(
                  onPressed: () async {
                    final title = _titleController.text.trim();
                    final content = _contentController.text.trim();

                    if (_formKey.currentState?.validate() ?? false) {
                      // Set loading state to true while submitting
                      setState(() {
                        _isSubmitting = true;
                      });

                      final loggedInUser = ref.read(userProvider);

                      if (loggedInUser != null) {
                        final success = await GraphQLService().createDiary(
                          userId:
                              "678938ae4568454eb72369f2", // TODO: loggedInUser.id
                          title: title,
                          content: content,
                        );

                        setState(() {
                          _isSubmitting = false; // Reset loading state
                        });

                        if (success) {
                          Navigator.of(context).pop();
                          _titleController.clear();
                          _contentController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Diary entry added!')),
                          );

                          // Re-fetch diaries after adding a new one to update the list
                          ref.read(diaryProvider.notifier).fetchDiaries(
                              "678938ae4568454eb72369f2"); //TODO loggedInUser.id
                        } else {
                          Navigator.of(context).pop();
                          _titleController.clear();
                          _contentController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Failed to create diary entry')),
                          );
                        }
                      }
                    }
                  },
                  child: _isSubmitting
                      ? const CircularProgressIndicator() // Show spinner while submitting
                      : const Text('Add Diary'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final diaries = ref.watch(diaryProvider);

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

//  Format Date
String formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}
