import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';

class JournalArchivePage extends StatefulWidget {
  const JournalArchivePage({super.key});

  @override
  State<JournalArchivePage> createState() => _JournalArchivePageState();
}

class _JournalArchivePageState extends State<JournalArchivePage> {
  int _currentIndex = 0;

  final List<Map<String, String>> journalEntries = [
    {
      "title": "Gratitude",
      "preview":
          "Today, I’m thankful for the quiet morning I had with my coffee, the unexpected message from an old friend, and the way the sky turned orange at sunset……",
    },
    {
      "title": "Personal Growth",
      "preview":
          "Looking back, I can see how much I’ve grown. A year ago, I would’ve avoided conflict, but now I’m learning to speak up. I still get nervous, but I’m proud……",
    },
    {
      "title": "Goal Setting",
      "preview":
          "I want to finish reading one book this month and take better care of my sleep schedule. Just small steps. Maybe reading 10 pages a night before bed instead of scrolling……",
    },
    {
      "title": "Emotional Check-In",
      "preview":
          "Lately, I’ve been feeling overwhelmed. There’s this low hum of anxiety in the background, especially when I think about work. But when I went for a walk today……",
    },
    {
      "title": "Resilience",
      "preview":
          "This week tested me. I got feedback that stung more than I expected. But instead of shutting down, I took a step back, gave myself some space, and re-read…..",
    },
    {
      "title": "Relationships",
      "preview":
          "I’ve been thinking about my relationship with my sister. We don’t talk as often as we used to, and I miss her. Maybe I’ll send her a voice note tomorrow……",
    },
    {
      "title": "Self-Compassion",
      "preview":
          "Hey, I know you’ve been trying your best—even if it doesn’t always……",
    },
    {
      "title": "Dreams & Aspirations",
      "preview": "I keep picturing this little cabin in the woods where……",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Journal Archive",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Menu tapped")));
            },
          ),
        ],
      ),

      // Body with Grid
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: journalEntries.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // two cards per row
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9, // adjust height
          ),
          itemBuilder: (context, index) {
            final entry = journalEntries[index];
            return GestureDetector(
              onTap: () {
                // TODO: Navigate to detail page
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400.withOpacity(0.5),
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                  border: Border.all(
                    color: index == 1
                        ? Colors
                              .blue // highlight example
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry["title"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(thickness: 0.8),
                    Expanded(
                      child: Text(
                        entry["preview"]!,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: SafeArea(
        top: false,
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
