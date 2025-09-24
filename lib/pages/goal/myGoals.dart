import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journapp/common/bottomNavigationBar.dart';
import 'package:journapp/pages/goal/addGoal.dart';

class MyGoalsPage extends StatefulWidget {
  const MyGoalsPage({super.key});

  @override
  State<MyGoalsPage> createState() => _MyGoalsPageState();
}

class _MyGoalsPageState extends State<MyGoalsPage> {
  int _currentIndex = 3;

  // Goals data (added progress for demo)
  final List<Map<String, dynamic>> goals = [
    {
      "title": "Gratitude",
      "subtitle": "30 Entries",
      "progress": 0.7,
      "color": Colors.lightBlueAccent,
    },
    {
      "title": "Meditation",
      "subtitle": "120 Hours",
      "progress": 0.5,
      "color": Colors.pinkAccent.shade100,
    },
    {
      "title": "Moon Cycle",
      "subtitle": "5 Entries",
      "progress": 0.2,
      "color": Colors.green.shade300,
    },
    {
      "title": "Moods",
      "subtitle": "29 Sessions",
      "progress": 0.9,
      "color": Colors.black,
    },
    {
      "title": "Family and People",
      "subtitle": "300 Entries",
      "progress": 0.8,
      "color": Colors.grey.shade400,
    },
    {
      "title": "Favorites",
      "subtitle": "0 Entries",
      "progress": 0.0,
      "color": Colors.orange.shade300,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Goals",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              if (value == "add") {
                Get.to(() => const AddGoalPage());
              } else if (value == "edit") {
                // TODO: Handle Edit
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "add", child: Text("Add Goal")),
              const PopupMenuItem(value: "edit", child: Text("Edit Goals")),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: goals.isEmpty
            ? _buildEmptyState()
            : GridView.builder(
                itemCount: goals.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  return _buildGoalCard(
                    title: goal["title"],
                    subtitle: goal["subtitle"],
                    color: goal["color"],
                    progress: goal["progress"],
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

  /// Goal Card Widget
  Widget _buildGoalCard({
    required String title,
    required String subtitle,
    required Color color,
    double? progress, // allow nullable
  }) {
    final bool isDark = color.computeLuminance() < 0.5;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Will open  $title")));
        // TODO: Navigate to goal details page
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (progress ?? 0.0).clamp(
                      0.0,
                      1.0,
                    ), // ✅ safe default & bounds
                    backgroundColor: isDark ? Colors.white24 : Colors.black12,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Empty state UI when no goals
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.flag, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            "No goals yet!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          const Text(
            "Start by adding your first goal to stay motivated.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Get.to(() => const AddGoalPage()),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Add Goal"),
          ),
        ],
      ),
    );
  }
}
