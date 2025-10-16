import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';
import 'package:journapp/pages/plan/monthlyPlan.dart';
import 'package:journapp/pages/plan/weeklyPlan.dart';

class MyPlanPage extends StatefulWidget {
  const MyPlanPage({super.key});

  @override
  State<MyPlanPage> createState() => _MyPlanPageState();
}

class _MyPlanPageState extends State<MyPlanPage> {
  int _currentIndex = 3;
  String _filter = "Daily";

  final List<Map<String, dynamic>> todayPlans = [
    {
      "title": "Breakfast",
      "subtitle": "Fresh Food",
      "time": "06:30",
      "done": true,
    },
    {
      "title": "Running",
      "subtitle": "5km Stadium",
      "time": "07:30",
      "done": false,
    },
    {
      "title": "Training",
      "subtitle": "1hr Gym",
      "time": "10:30",
      "done": false,
    },
  ];

  final List<Map<String, dynamic>> yesterdayPlans = [
    {
      "title": "Running",
      "subtitle": "10km Road",
      "time": "06:30",
      "done": true,
    },
    {
      "title": "Stretching",
      "subtitle": "Post-run routine",
      "time": "07:45",
      "done": true,
    },
    {
      "title": "Gym Session",
      "subtitle": "Upper body",
      "time": "10:30",
      "done": false,
    },
  ];

  void _changeFilter(String value) {
    setState(() {
      _filter = value;
    });

    if (value == "Weekly") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WeeklyPlanPage()),
      );
    } else if (value == "Daily") {
      // Stay on current page or go back to daily view
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

  Widget _buildPlanItem(Map<String, dynamic> plan) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          final wasDone = plan["done"];
          setState(() {
            plan["done"] = !wasDone;
          });
          // Show friendly feedback
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_getTaskFeedback(plan["title"], !wasDone)),
              duration: const Duration(milliseconds: 1200),
              backgroundColor: Colors.grey.shade800,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: plan["done"]
                      ? Colors.green.shade500
                      : Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: plan["done"]
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan["title"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: plan["done"]
                            ? Colors.grey.shade600
                            : Colors.black87,
                        decoration: plan["done"]
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      plan["subtitle"],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                plan["time"],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: plan["done"]
                      ? Colors.grey.shade500
                      : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> plans) {
    if (plans.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(Icons.event_available, size: 60, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No plans scheduled',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              _filter == 'Daily'
                  ? 'Add your first plan for today!'
                  : 'Plans for this $_filter will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    final allDone = plans.every((p) => p['done'] == true);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 8),
                if (allDone)
                  Icon(
                    Icons.check_circle,
                    size: 18,
                    color: Colors.green.shade600,
                  ),
              ],
            ),
          ),
          if (allDone)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Text(
                'All done! 🎉',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ...List.generate(plans.length, (index) {
            return Column(
              children: [
                _buildPlanItem(plans[index]),
                if (index < plans.length - 1)
                  const Divider(height: 1, indent: 52, endIndent: 16),
              ],
            );
          }),
        ],
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
          onPressed: () => Navigator.of(context).pop(),
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
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: Text(
                "Viewing: $_filter",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            _buildSection("Today", todayPlans),
            _buildSection("Yesterday", yesterdayPlans),
            const SizedBox(height: 32), // extra padding for bottom nav
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
