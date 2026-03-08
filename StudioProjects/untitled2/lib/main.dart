import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InstagramLiveScreen(),
    );
  }
}

class InstagramLiveScreen extends StatefulWidget {
  const InstagramLiveScreen({super.key});

  @override
  State<InstagramLiveScreen> createState() => _InstagramLiveScreenState();
}

class _InstagramLiveScreenState extends State<InstagramLiveScreen> {
  List<String> comments = ["karennne joined"];
  final TextEditingController commentController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void sendComment() {
    if (commentController.text.isNotEmpty) {
      setState(() {
        comments.add("You: ${commentController.text}");
      });
      commentController.clear();
      _scrollToBottom();
    }
  }

  void addReaction(String reaction) {
    setState(() {
      comments.add("You: $reaction");
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/photo.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
          ),
          const Positioned(top: 50, left: 15, right: 15, child: TopLiveBar()),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 10,
            left: 0,
            right: 0,
            child: BottomLivePanel(
              comments: comments,
              controller: commentController,
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

class TopLiveBar extends StatelessWidget {
  const TopLiveBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage('assets/images/photo.png'),
        ),
        const SizedBox(width: 10),
        const Text(
          'maxjacobson',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.red, Colors.purple]),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'LIVE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Row(
            children: [
              Icon(Icons.remove_red_eye, color: Colors.white, size: 14),
              SizedBox(width: 4),
              Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ),
        const Spacer(),
        const Icon(Icons.close, color: Colors.white, size: 28),
      ],
    );
  }
}

class BottomLivePanel extends StatefulWidget {
  final List<String> comments;
  final TextEditingController controller;
  final ScrollController scrollController;
  final VoidCallback onSend;
  final Function(String) onReaction;

  const BottomLivePanel({
    super.key,
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
  bool requested = false;
  bool liked = false;

  void toggleRequest() {
    setState(() {
      requested = !requested;
    });
  }

  void toggleLike() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
                    (c) => Text(
                      c,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 14,
                child: Icon(Icons.person, size: 16),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  "Send request to join live",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              TextButton(
                onPressed: toggleRequest,
                child: Text(
                  requested ? "Requested" : "Request",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
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
                icon: const Icon(Icons.send_outlined, color: Colors.white),
              ),
              IconButton(
                onPressed: toggleLike,
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

class ReactionChip extends StatelessWidget {
  final String label;
  final Function(String) onTap;

  const ReactionChip({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}
