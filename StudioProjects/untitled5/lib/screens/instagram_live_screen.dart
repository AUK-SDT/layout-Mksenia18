import 'package:flutter/material.dart';
import '../models/live_user.dart';
import '../widgets/top_live_bar.dart';
import '../widgets/bottom_live_panel.dart';

class InstagramLiveScreen extends StatefulWidget {
  final LiveUser user;

  const InstagramLiveScreen({super.key, required this.user});

  @override
  State<InstagramLiveScreen> createState() => _InstagramLiveScreenState();
}

class _InstagramLiveScreenState extends State<InstagramLiveScreen> {
  List<String> comments = ["joined the live"];
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void sendComment() {
    if (controller.text.isNotEmpty) {
      setState(() {
        comments.add("You: ${controller.text}");
      });
      controller.clear();
      scrollToBottom();
    }
  }

  void addReaction(String reaction) {
    setState(() {
      comments.add("You: $reaction");
    });
    scrollToBottom();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(widget.user.background, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 15,
            right: 15,
            child: TopLiveBar(user: widget.user),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 10,
            left: 0,
            right: 0,
            child: BottomLivePanel(
              user: widget.user,
              comments: comments,
              controller: controller,
              scrollController: scrollController,
              onSend: sendComment,
              onReaction: addReaction,
            ),
          ),
        ],
      ),
    );
  }
}
