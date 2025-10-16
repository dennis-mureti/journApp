import 'dart:math';
import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';

class JournalArchivePage extends StatefulWidget {
  const JournalArchivePage({super.key});

  @override
  State<JournalArchivePage> createState() => _JournalArchivePageState();
}

class _JournalArchivePageState extends State<JournalArchivePage> {
  int _currentIndex = 3;

  final List<Map<String, String>> journalEntries = [
    {
      "title": "Gratitude",
      "desc":
          "Today, I’m thankful for the quiet morning I had with my coffee, the unexpected message from an old friend...",
    },
    {
      "title": "Personal Growth",
      "desc":
          "Looking back, I can see how much I’ve grown. A year ago, I would’ve avoided conflict, but now...",
    },
    {
      "title": "Goal Setting",
      "desc":
          "I want to finish reading one book this month and take better care of my sleep schedule. Just small steps...",
    },
    {
      "title": "Emotional Check-In",
      "desc":
          "Lately, I’ve been feeling overwhelmed. There’s this low hum of anxiety in the background, especially...",
    },
    {
      "title": "Resilience",
      "desc":
          "This week tested me. I got feedback that stung more than I expected. But instead of shutting down...",
    },
    {
      "title": "Relationships",
      "desc":
          "I’ve been thinking about my relationship with my sister. We don’t talk as often as we used to...",
    },
    {
      "title": "Self-Compassion",
      "desc":
          "Hey, I know you’ve been trying your best—even if it doesn’t always feel like enough...",
    },
    {
      "title": "Dreams & Aspirations",
      "desc":
          "I keep picturing this little cabin in the woods where I can relax and reset...",
    },
  ];

  final List<Color> pastelColors = [
    Color(0xFFFFF3E0), // soft orange
    Color(0xFFE1F5FE), // soft blue
    Color(0xFFF3E5F5), // soft purple
    Color(0xFFE8F5E9), // soft green
    Color(0xFFFFEBEE), // soft pink
    Color(0xFFFFF9C4), // soft yellow
    Color(0xFFD1C4E9), // lavender
    Color(0xFFFFE0B2), // peach
  ];

  late List<Color> assignedColors;

  @override
  void initState() {
    super.initState();
    final random = Random();
    assignedColors = List.generate(
      journalEntries.length,
      (_) => pastelColors[random.nextInt(pastelColors.length)],
    );
  }

  void _handleCardTap(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Opening \"$title\" entry..."),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Journal Archive",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Sort & filter options coming soon!"),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: journalEntries.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final entry = journalEntries[index];
            final bgColor = assignedColors[index];

            return GestureDetector(
              onTap: () => _handleCardTap(entry["title"]!),
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry["title"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const Divider(height: 14, thickness: 0.7),
                    Expanded(
                      child: Text(
                        entry["desc"]!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
        ),
      ),
    );
  }
}
