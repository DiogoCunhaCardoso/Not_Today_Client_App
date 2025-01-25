import 'package:flutter/material.dart';
import 'package:not_today_client/models/data/dummy_data.dart'; // Import the dummy data
import 'package:not_today_client/models/addictions.dart';

class AddictionDetailScreen extends StatelessWidget {
  final String addictionId; // To hold the id passed from the previous screen

  // Constructor to initialize the addictionId
  const AddictionDetailScreen({super.key, required this.addictionId});

  String getAddictionLabel(AddictionType addictionType) {
    switch (addictionType) {
      case AddictionType.alcohol:
        return 'Alcohol';
      case AddictionType.attentionSeeking:
        return 'Attention Seeking';
      case AddictionType.badLanguage:
        return 'Bad Language';
      case AddictionType.caffeine:
        return 'Caffeine';
      case AddictionType.dairy:
        return 'Dairy';
      case AddictionType.drug:
        return 'Drugs';
      case AddictionType.fastFood:
        return 'Fast Food';
      case AddictionType.gambling:
        return 'Gambling';
      case AddictionType.nailBiting:
        return 'Nail Biting';
      case AddictionType.porn:
        return 'Porn';
      case AddictionType.procrastination:
        return 'Procrastination';
      case AddictionType.selfHarm:
        return 'Self Harm';
      case AddictionType.smoking:
        return 'Smoking';
      case AddictionType.socialMedia:
        return 'Social Media';
      case AddictionType.softDrinks:
        return 'Soft Drinks';
      case AddictionType.sugar:
        return 'Sugar';
      case AddictionType.vaping:
        return 'Vaping';
      default:
        return 'Unknown';
    }
  }

  // Method to show the delete confirmation dialog
  Future<void> _showDeleteDialog(
      BuildContext context, String addictionType) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete $addictionType Addiction?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Are you sure you want to delete this addiction? This action can\'t be undone.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                print('Addiction $addictionType deleted.');
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Find the addiction by id, assuming the id exists
    final userAddiction = userAddictions.firstWhere(
      (addiction) => addiction.id == addictionId,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(userAddiction.addictionType),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Show the delete confirmation dialog when clicked
              _showDeleteDialog(
                context,
                getAddictionLabel(AddictionType.values.firstWhere(
                  (e) =>
                      e.toString().split('.').last ==
                      userAddiction.addictionType.toLowerCase(),
                )),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Addiction Details:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'ID: ${userAddiction.id}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Addiction Type: ${getAddictionLabel(AddictionType.values.firstWhere((e) => e.toString().split('.').last == userAddiction.addictionType.toLowerCase()))}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Sober Days: ${userAddiction.soberDays}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'User ID: ${userAddiction.userId}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
