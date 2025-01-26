import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_today_client/providers/user_addiction_provider.dart';
import 'package:not_today_client/providers/user_provider.dart';
import 'package:not_today_client/screens/main/otherPages/addiction_detail_screen.dart';
import 'package:not_today_client/utils/addiction_helpers.dart';

class AddictionScreen extends ConsumerWidget {
  const AddictionScreen({super.key});

  // Method to open a bottom sheet with a list of AddictionTypes
  void _openAddictionBottomSheet(BuildContext context, WidgetRef ref) {
    final userAddictions = ref.watch(userAddictionProvider);
    final userAddictionNotifier = ref.read(userAddictionProvider.notifier);

    // Get the currently logged-in user
    final loggedInUser = ref.watch(userProvider);

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
                final isAlreadyAdded = userAddictions.any(
                  (addiction) =>
                      addiction.addictionType.toLowerCase() ==
                          addictionType.name.toLowerCase() &&
                      addiction.userId == loggedInUser?.id,
                );

                return ListTile(
                  leading: Icon(
                    getAddictionIcon(addictionType),
                    color: isAlreadyAdded ? Colors.black26 : null,
                  ),
                  title: Text(
                    getAddictionLabel(addictionType),
                    style: TextStyle(
                      color: isAlreadyAdded ? Colors.black26 : null,
                    ),
                  ),
                  onTap: isAlreadyAdded
                      ? null // Disable interaction if already added
                      : () {
                          if (loggedInUser != null) {
                            // Add a new addiction with default values
                            userAddictionNotifier.addAddiction(
                              UserAddiction(
                                id: 'addiction_${DateTime.now().millisecondsSinceEpoch}',
                                userId: loggedInUser.id,
                                addictionType: addictionType.name.toUpperCase(),
                                severity: 'Low',
                                reasonAmount: 0,
                                motivation: [],
                                soberDays: 0,
                              ),
                            );
                          }
                          Navigator.pop(context);
                        },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the currently logged-in user
    final loggedInUser = ref.watch(userProvider);

    // Watch the addictionProvider for logged-in user addictions
    final userAddictions = loggedInUser != null
        ? ref
            .watch(userAddictionProvider.notifier)
            .getLoggedInUserAddictions(loggedInUser.id)
        : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Addictions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _openAddictionBottomSheet(context, ref);
            },
          ),
        ],
      ),
      body: userAddictions.isEmpty
          ? const Center(child: Text("No addictions added"))
          : SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
                                ?.copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                          const TextSpan(
                            text: ' people are with you on this journey',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // ListView to display user addictions
                    Expanded(
                      child: ListView.builder(
                        itemCount: userAddictions.length,
                        itemBuilder: (context, index) {
                          final userAddiction = userAddictions[index];

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: ListTile(
                              leading: Icon(
                                getAddictionIcon(
                                  AddictionType.values.firstWhere(
                                    (type) =>
                                        type.name.toLowerCase() ==
                                        userAddiction.addictionType
                                            .toLowerCase(),
                                    orElse: () => AddictionType.alcohol,
                                  ),
                                ),
                              ),
                              title: Text(userAddiction.addictionType),
                              subtitle: Text(
                                  "Sober Days: ${userAddiction.soberDays}"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddictionDetailScreen(
                                      addictionId: userAddiction.id,
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
