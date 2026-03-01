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

class InstagramLiveScreen extends StatelessWidget {
  const InstagramLiveScreen({super.key});

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
                  colors: [Colors.transparent, Colors.black.withValues()],
                ),
              ),
            ),
          ),

          const Positioned(top: 50, left: 15, right: 15, child: TopLiveBar()),

          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 10,
            left: 0,
            right: 0,
            child: const BottomLivePanel(),
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
        CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage('assets/images/photo.png'),
        ),
        const SizedBox(width: 10),
        const Text(
          'maxjacobson',
          key: Key('usernameText'),
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

class BottomLivePanel extends StatelessWidget {
  const BottomLivePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'karennne joined',
            style: TextStyle(color: Colors.white70, fontSize: 13),
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
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: const Icon(Icons.person, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Send a request to be in maxjacobson\'s live video.',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              TextButton(
                key: const Key('requestButton'),
                onPressed: () {},
                child: const Text(
                  'Request',
                  style: TextStyle(color: Colors.white),
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
            children: const [
              ReactionChip(label: 'Hello'),
              ReactionChip(label: '😂'),
              ReactionChip(label: '😍'),
              ReactionChip(label: '👋'),
              ReactionChip(label: '👍'),
              ReactionChip(label: '🔥🔥'),
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
                  key: const Key('commentField'),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Comment',
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send_outlined, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border, color: Colors.white),
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
  const ReactionChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}
