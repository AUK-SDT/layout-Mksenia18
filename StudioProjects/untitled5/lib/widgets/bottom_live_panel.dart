import 'package:flutter/material.dart';
import '../models/live_user.dart';
import 'reaction_chip.dart';

class BottomLivePanel extends StatefulWidget {
  final LiveUser user;
  final List<String> comments;
  final TextEditingController controller;
  final ScrollController scrollController;
  final VoidCallback onSend;
  final Function(String) onReaction;

  const BottomLivePanel({
    super.key,
    required this.user,
    required this.comments,
    required this.controller,
    required this.scrollController,
    required this.onSend,
    required this.onReaction,
  });

  @override
  State<BottomLivePanel> createState() => _BottomLivePanelState();
}

class _BottomLivePanelState extends State<BottomLivePanel> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: 80,
            child: ListView(
              controller: widget.scrollController,
              children: widget.comments
                  .map(
                    (c) =>
                        Text(c, style: const TextStyle(color: Colors.white70)),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 35,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              ReactionChip(label: "Hello", onTap: widget.onReaction),
              ReactionChip(label: "😂", onTap: widget.onReaction),
              ReactionChip(label: "😍", onTap: widget.onReaction),
              ReactionChip(label: "👋", onTap: widget.onReaction),
              ReactionChip(label: "👍", onTap: widget.onReaction),
              ReactionChip(label: "🔥", onTap: widget.onReaction),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Comment",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => widget.onSend(),
                ),
              ),
              IconButton(
                onPressed: widget.onSend,
                icon: const Icon(Icons.send, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    liked = !liked;
                  });
                },
                icon: Icon(
                  Icons.favorite,
                  color: liked ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
