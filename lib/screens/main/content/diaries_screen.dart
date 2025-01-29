import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:not_today_client/graphql/graphql_service.dart';
import 'package:not_today_client/utils/secure_storage.dart';

class DiariesScreen extends StatefulWidget {
  const DiariesScreen({super.key});

  @override
  DiariesScreenState createState() => DiariesScreenState();
}

class DiariesScreenState extends State<DiariesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String? _titleError;
  String? _contentError;
  bool _isSubmitting = false;

  List<Map<String, dynamic>> diaries = [];

  @override
  void initState() {
    super.initState();
    // Fetch the diaries when the screen loads
    _fetchDiaries();
  }

  // Fetch diaries from GraphQL
  Future<void> _fetchDiaries() async {
    try {
      // Retrieve the token from SecureStorage
      String? token = await SecureStorage.retrieveToken(); // Get the token

      if (token == null || token.isEmpty) {
        print("No token found, user is not authenticated.");
        return;
      }

      // Use the token to fetch diaries
      final fetchedDiaries = await GraphQLService().getDiaries();

      setState(() {
        diaries = fetchedDiaries; // Update the diaries list in the state
      });
      print(fetchedDiaries);
    } catch (e) {
      // Handle any error fetching diaries (e.g., show an error message)
      print("Error fetching diaries: $e");
    }
  }

  // Show Add Diary Bottom Sheet
  void _showAddDiaryBottomSheet(BuildContext context) {
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

                      try {
                        // Call createDiary function from GraphQLService
                        final success = await GraphQLService().createDiary(
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
                          await _fetchDiaries();
                        }
                      } catch (e) {
                        setState(() {
                          _isSubmitting = false;
                        });

                        // Check for the specific error and show it
                        if (e is Exception) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e
                                  .toString()), // Show the specific error message
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to create diary entry'),
                            ),
                          );
                          Navigator.pop(context);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Diary"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDiaryBottomSheet(context),
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
                    title: Text(diary['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          diary['content'].length > 30
                              ? '${diary['content'].substring(0, 30)}...'
                              : diary['content'],
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formatDate(diary['date']),
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(diary['title']),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(diary['content']),
                                  const SizedBox(height: 10),
                                  Text('Date: ${formatDate(diary['date'])}'),
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
                              TextButton(
                                onPressed: () async {
                                  bool success = await GraphQLService()
                                      .deleteDiary(diary['id']);
                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Diary deleted successfully')),
                                    );
                                    Navigator.of(context).pop();
                                    _fetchDiaries(); // Refresh list
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Failed to delete diary')),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
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

// Format Date
String formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}
