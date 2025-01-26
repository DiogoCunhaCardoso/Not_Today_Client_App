import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_today_client/providers/user_addiction_provider.dart';
import 'package:not_today_client/utils/addiction_helpers.dart';

class AddictionDetailScreen extends ConsumerWidget {
  final String addictionId; // Recebe o ID do vício

  const AddictionDetailScreen({super.key, required this.addictionId});

  Future<void> _showDeleteDialog(
      BuildContext context, String addictionType, WidgetRef ref) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete $addictionType Addiction?'),
          content: const Text(
              'Are you sure you want to delete this addiction? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                ref
                    .read(userAddictionProvider.notifier)
                    .removeAddiction(addictionId); // Remove o vício
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Recupera a lista de vícios do provider
    final userAddictions = ref.watch(userAddictionProvider);

    // Encontra o vício correspondente ao ID
    final userAddiction = userAddictions.firstWhere(
      (addiction) => addiction.id == addictionId,
      orElse: () => throw Exception('Addiction not found!'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(userAddiction.addictionType),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteDialog(
                context,
                getAddictionLabel(
                  AddictionType.values.firstWhere(
                    (type) =>
                        type.name.toLowerCase() ==
                        userAddiction.addictionType.toLowerCase(),
                  ),
                ),
                ref,
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
                'Addiction Type: ${getAddictionLabel(AddictionType.values.firstWhere((type) => type.name.toLowerCase() == userAddiction.addictionType.toLowerCase()))}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Severity: ${userAddiction.severity}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Motivation: ${userAddiction.motivation.join(', ')}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Reason Amount: ${userAddiction.reasonAmount}',
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
