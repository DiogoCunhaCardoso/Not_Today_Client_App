import 'package:flutter/material.dart';
import 'package:not_today_client/models/data/dummy_data.dart'; // Import the dummy data
import 'package:not_today_client/models/addictions.dart';
import 'package:not_today_client/screens/main/otherPages/addiction_detail_screen.dart'; // Import the Addictions model

class AddictionScreen extends StatelessWidget {
  const AddictionScreen({super.key});

  // Method to open a bottom sheet with a list of AddictionTypes
  void _openAddictionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: AddictionType.values.length,
              itemBuilder: (context, index) {
                final addictionType = AddictionType.values[index];
                return ListTile(
                  leading:
                      Icon(getAddictionIcon(addictionType)), // Access the icon
                  title: Text(
                      getAddictionLabel(addictionType)), // Access the label
                );
              },
            ),
          ),
        );
      },
    );
  }

  // Method to get the icon for the addiction type
  IconData getAddictionIcon(AddictionType addictionType) {
    switch (addictionType) {
      case AddictionType.alcohol:
        return Icons.local_bar;
      case AddictionType.attentionSeeking:
        return Icons.visibility;
      case AddictionType.badLanguage:
        return Icons.sentiment_dissatisfied;
      case AddictionType.caffeine:
        return Icons.coffee;
      case AddictionType.dairy:
        return Icons.icecream;
      case AddictionType.drug:
        return Icons.medical_services;
      case AddictionType.fastFood:
        return Icons.fastfood;
      case AddictionType.gambling:
        return Icons.casino;
      case AddictionType.nailBiting:
        return Icons.face;
      case AddictionType.porn:
        return Icons.no_adult_content;
      case AddictionType.procrastination:
        return Icons.access_time;
      case AddictionType.selfHarm:
        return Icons.self_improvement;
      case AddictionType.smoking:
        return Icons.smoking_rooms;
      case AddictionType.socialMedia:
        return Icons.phone_android;
      case AddictionType.softDrinks:
        return Icons.local_drink;
      case AddictionType.sugar:
        return Icons.food_bank;
      case AddictionType.vaping:
        return Icons.air;
      default:
        return Icons.help;
    }
  }

  // Method to get the label for the addiction type
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Addictions"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _openAddictionBottomSheet(
                  context); // Open the bottom sheet when pressed
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: [
                    TextSpan(
                      text: '4792',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    const TextSpan(
                      text: ' people are with you on this journey',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // ListView to display user addictions (existing code)
              Expanded(
                child: ListView.builder(
                  itemCount: userAddictions.length,
                  itemBuilder: (context, index) {
                    final userAddiction = userAddictions[index];

                    // Convert addictionType from string to AddictionType enum
                    final addictionType = AddictionType.values.firstWhere(
                      (e) =>
                          e.toString().split('.').last.toLowerCase() ==
                          userAddiction.addictionType.trim().toLowerCase(),
                      orElse: () => AddictionType.alcohol, // Default value
                    );

                    // Debug log to see the mapped addiction type
                    print("Mapped AddictionType: $addictionType");

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        leading: Icon(getAddictionIcon(addictionType)),
                        title: Text(getAddictionLabel(addictionType)),
                        subtitle:
                            Text("Sober Days: ${userAddiction.soberDays}"),
                        onTap: () {
                          // Navigate to the AddictionDetailScreen and pass the ID
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddictionDetailScreen(
                                addictionId:
                                    userAddiction.id, // Pass the id here
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
