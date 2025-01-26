import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_today_client/providers/user_provider.dart';
import 'package:not_today_client/providers/user_milestone_provider.dart'; // Import the milestone provider
import 'package:not_today_client/screens/auth/login_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLogged = ref.watch(userProvider);
    final userLoggedNotifier = ref.read(userProvider.notifier);

    // Fetch user milestones using the provider's method
    final loggedInUserMilestones = ref
        .read(userMilestoneProvider.notifier)
        .getLoggedInUserMilestones(userLogged!.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              userLoggedNotifier.logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile section
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  userLogged.pfp != null ? NetworkImage(userLogged.pfp!) : null,
              child: userLogged.pfp == null ? Text(userLogged.name[0]) : null,
            ),
            const SizedBox(height: 16),
            Text(
              userLogged.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(userLogged.email),

            const SizedBox(height: 32),

            // Horizontally scrollable list for milestones
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 160, // Define height of the horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: loggedInUserMilestones.isNotEmpty
                      ? loggedInUserMilestones.length
                      : 3, // Show 3 placeholders if no milestones
                  itemBuilder: (context, index) {
                    if (loggedInUserMilestones.isEmpty) {
                      // Placeholder card if no milestones
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            width: 120, // Each item width
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons
                                      .star_border, // Placeholder icon for no milestone
                                  size: 40,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'No Milestone',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Level N/A',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      final milestone = loggedInUserMilestones[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            width: 120, // Each item width
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Display milestone icon (based on name)
                                const Icon(
                                  Icons
                                      .star, // You can change this to represent the milestone
                                  size: 40,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  milestone.name
                                      .toString()
                                      .split('.')
                                      .last, // Show the name (formatted)
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                // Display milestone level
                                Text(
                                  'Level ${milestone.level}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
