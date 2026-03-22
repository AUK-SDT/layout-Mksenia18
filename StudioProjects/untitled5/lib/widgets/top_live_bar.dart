import 'package:flutter/material.dart';
import '../models/live_user.dart';
import '../screens/profile_screen.dart';

class TopLiveBar extends StatelessWidget {
  final LiveUser user;

  const TopLiveBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfileScreen(user: user)),
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(user.avatar),
              ),
              const SizedBox(width: 10),
              Text(
                user.username,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text("LIVE", style: TextStyle(color: Colors.white)),
        ),

        const Spacer(),

        IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
