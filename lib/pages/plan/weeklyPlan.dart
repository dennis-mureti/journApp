// lib/pages/plan/weeklyPlanPage.dart

import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';
import 'package:journapp/pages/plan/monthlyPlan.dart';
import 'package:journapp/pages/plan/myPlan.dart';

class WeeklyPlanPage extends StatefulWidget {
  const WeeklyPlanPage({super.key});

  @override
  State<WeeklyPlanPage> createState() => _WeeklyPlanPageState();
}

class _WeeklyPlanPageState extends State<WeeklyPlanPage> {
  int _currentIndex = 3;
  String _filter = "Weekly";

  final Map<String, List<Map<String, dynamic>>> weeklyPlans = {
    'Sunday': [
      {
        'title': 'Breakfast',
        'subtitle': 'Fresh Food',
        'time': '06:30',
        'done': false,
      },
      {
        'title': 'Prayer',
        'subtitle': 'Morning Reflection',
        'time': '07:30',
        'done': true,
      },
    ],
    'Monday': [
      {
        'title': 'Meditation',
        'subtitle': '10km Road',
        'time': '06:30',
        'done': true,
      },
      {
        'title': 'Running',
        'subtitle': '5km Stadium',
        'time': '07:30',
        'done': false,
      },
    ],
    'Tuesday': [
      {
        'title': 'Reading',
        'subtitle': 'Book Club',
        'time': '08:00',
        'done': false,
      },
    ],
    'Wednesday': [],
    'Thursday': [
      {
        'title': 'Review',
        'subtitle': 'Weekly Goals',
        'time': '17:00',
        'done': false,
      },
    ],
    'Friday': [],
    'Saturday': [
      {
        'title': 'Hike',
        'subtitle': 'Mountain Trail',
        'time': '08:00',
        'done': false,
      },
    ],
  };

  void _changeFilter(String value) {
    if (value == _filter) return;
    setState(() => _filter = value);

    if (value == "Daily") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyPlanPage()),
      );
    } else if (value == "Monthly") {
      // Navigate to MonthlyPlanPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MonthlyPlanPage()),
      );
    }
  }

  String _getTaskFeedback(String title, bool isNowDone) {
    if (isNowDone) {
      return "✅ $title — Nice work!";
    } else {
      return "↩️ $title — Back on your list.";
    }
  }

  Widget _buildTaskItem(Map<String, dynamic> task, {bool isLast = false}) {
    final bool isDone = task["done"] ?? false;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        setState(() {
          task["done"] = !isDone;
        });
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_getTaskFeedback(task["title"], !isDone)),
            duration: const Duration(milliseconds: 1200),
            backgroundColor: Colors.grey.shade800,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isDone ? Colors.green.shade500 : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: isDone
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task["title"],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDone ? Colors.grey.shade600 : Colors.black87,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    task["subtitle"],
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Text(
              task["time"],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDone ? Colors.grey.shade500 : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySection(String day, List<Map<String, dynamic>> tasks) {
    final allDone =
        tasks.isNotEmpty && tasks.every((t) => (t['done'] ?? false));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        // ✅ Added outer padding to push content away from card edges
        padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                if (allDone) const SizedBox(width: 8),
                if (allDone)
                  Icon(
                    Icons.check_circle,
                    size: 18,
                    color: Colors.green.shade600,
                  ),
              ],
            ),
            if (allDone)
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 12),
                child: Text(
                  'All done! 🎉',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            else
              const SizedBox(height: 12),

            if (tasks.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'No plans scheduled',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              ...List.generate(tasks.length, (index) {
                return Column(
                  children: [
                    _buildTaskItem(
                      tasks[index],
                      isLast: index == tasks.length - 1,
                    ),
                    if (index < tasks.length - 1)
                      const Divider(height: 1, indent: 44, endIndent: 0),
                  ],
                );
              }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "My Plans",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onSelected: _changeFilter,
            itemBuilder: (context) => const [
              PopupMenuItem(value: "Daily", child: Text("Daily")),
              PopupMenuItem(value: "Weekly", child: Text("Weekly")),
              PopupMenuItem(value: "Monthly", child: Text("Monthly")),
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // ✅ Week day header (S M T W T F S)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
                  return Container(
                    width: 36,
                    alignment: Alignment.center,
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade300),

            // Filter indicator
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Text(
                "Viewing: $_filter",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Day sections
            ...weeklyPlans.entries.map((entry) {
              return _buildDaySection(entry.key, entry.value);
            }).toList(),

            const SizedBox(height: 40), // bottom padding for nav
          ],
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
