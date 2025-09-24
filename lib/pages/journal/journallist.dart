import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';
import 'package:journapp/pages/journal/journal.dart';
import 'package:journapp/pages/journal/promptjournal.dart';
import 'package:journapp/pages/visionBoard/visionBoard.dart';

class JournalListPage extends StatefulWidget {
  const JournalListPage({super.key});

  @override
  State<JournalListPage> createState() => _JournalListPageState();
}

class _JournalListPageState extends State<JournalListPage> {
  int _currentIndex = 0; // "Today" tab by default

  final List<Map<String, dynamic>> journals = [
    {"title": "Vision Board", "color": Colors.pink[200]},
    {"title": "Journal", "color": Colors.orange[200]},
    {"title": "Prompt Journaling", "color": Colors.green[300]},
    {"title": "Gratitude Log", "color": Colors.lightBlue[200]},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Journal Section",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.black),
            onSelected: (value) {
              if (value == "goal") {
                Navigator.pushNamed(context, "/addGoal");
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "goal", child: Text("Add Goal")),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: journals.length,
          itemBuilder: (context, index) {
            final journal = journals[index];
            return GestureDetector(
              onTap: () {
                if (journal["title"] == "Journal") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FreeJournalPage(),
                    ),
                  );
                }
                if (journal["title"] == "Prompt Journaling") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PromptJournalPage(),
                    ),
                  );
                }
                if (journal["title"] == "Vision Board") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VisionBoardPage(),
                    ),
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(
                  vertical: 80,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: journal["color"],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  journal["title"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
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
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
