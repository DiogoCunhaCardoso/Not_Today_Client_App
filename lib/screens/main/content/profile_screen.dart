import 'package:flutter/material.dart';
import 'package:not_today_client/screens/main/otherPages/settings_screen.dart';
import 'package:not_today_client/models/data/dummy_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Helper function to format the joined date
  String formatJoinedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Avatar and Name Section using actual user data
                CircleAvatar(
                  radius: 50, // Makes the avatar larger
                  child: Text(
                    users.name[0], // First letter of the user's name
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  users.name, // User's name from the `users` constant
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Joined: ${formatJoinedDate(DateTime(2024, 10, 5))}', // Show the actual joined date
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 20),

                // Milestones Horizontal Scroll List
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: userMilestones.length,
                      itemBuilder: (context, index) {
                        final milestone = userMilestones[index];

                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              width: 150, // Fixed width for each milestone
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Milestone Title
                                  Text(
                                    milestone.name.toString().split('.').last,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Milestone Level
                                  Text(
                                    'Level: ${milestone.level}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Milestone Date
                                  Text(
                                    'Achieved: ${milestone.achievedDate.day}/${milestone.achievedDate.month}/${milestone.achievedDate.year}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
