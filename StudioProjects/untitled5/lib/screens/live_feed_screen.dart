import 'package:flutter/material.dart';
import '../models/live_user.dart';
import 'instagram_live_screen.dart';

class LiveFeedScreen extends StatefulWidget {
  const LiveFeedScreen({super.key});

  @override
  State<LiveFeedScreen> createState() => _LiveFeedScreenState();
}

class _LiveFeedScreenState extends State<LiveFeedScreen> {
  final PageController controller = PageController(initialPage: 1000);

  final List<LiveUser> users = [
    LiveUser(
      username: "maxjacobson",
      avatar: "assets/images/photo1.png",
      background: "assets/images/photo1.png",
    ),
    LiveUser(
      username: "karennne",
      avatar: "assets/images/photo2.png",
      background: "assets/images/photo2.png",
    ),
    LiveUser(
      username: "alex_99",
      avatar: "assets/images/photo3.png",
      background: "assets/images/photo3.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final user = users[index % users.length];
        return InstagramLiveScreen(user: user);
      },
    );
  }
}
