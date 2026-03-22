import 'package:flutter/material.dart';
import '../models/live_user.dart';

class ProfileScreen extends StatelessWidget {
  final LiveUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.username), backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(radius: 50, backgroundImage: AssetImage(user.avatar)),
          const SizedBox(height: 15),
          Text(
            user.username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ProfileStat(title: "Posts", value: "0"),
              SizedBox(width: 20),
              ProfileStat(title: "Followers", value: "1.2K"),
              SizedBox(width: 20),
              ProfileStat(title: "Following", value: "180"),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            "This is a profile page",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String title;
  final String value;

  const ProfileStat({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(title, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
