import 'package:flutter/material.dart';
import 'package:not_today_client/graphql/graphql_service.dart';
import 'package:not_today_client/screens/auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  // Fetch user details
  Future<void> _fetchUser() async {
    final fetchedUser = await GraphQLService().fetchUserProfile();
    if (mounted) {
      setState(() {
        user = fetchedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await GraphQLService.deleteToken();
              if (mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        // Center the content
        child: user == null
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center items horizontally
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Text(
                      user!['name'][0], // Show first letter of name
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user!['name'],
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center, // Ensure text is centered
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user!['email'],
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
