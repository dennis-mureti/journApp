import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';
// import your external bottom nav widget here
// import 'my_bottom_nav_bar.dart';

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
      "time": "06.30",
      "done": true,
    },
    {
      "title": "Running",
      "subtitle": "5km Stadium",
      "time": "07.30",
      "done": false,
    },
    {
      "title": "Training",
      "subtitle": "1hr Gym",
      "time": "10.30",
      "done": false,
    },
  ];

  final List<Map<String, dynamic>> yesterdayPlans = [
    {
      "title": "Running",
      "subtitle": "10km Road",
      "time": "06.30",
      "done": true,
    },
    {
      "title": "Running",
      "subtitle": "5km Stadium",
      "time": "07.30",
      "done": false,
    },
    {
      "title": "Training",
      "subtitle": "1hr Gym",
      "time": "10.30",
      "done": false,
    },
  ];

  void _changeFilter(String value) {
    setState(() {
      _filter = value;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Switched to $_filter view")));
  }

  Widget _buildPlanItem(Map<String, dynamic> plan, {bool isLast = false}) {
    return InkWell(
      onTap: () {
        setState(() {
          plan["done"] = !plan["done"];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${plan["title"]} marked as ${plan["done"] ? "done" : "not done"}",
            ),
          ),
        );
      },
      child: Row(
        children: [
          Column(
            children: [
              Icon(
                Icons.circle,
                size: 12,
                color: plan["done"] ? Colors.black : Colors.grey,
              ),
              if (!isLast)
                Container(height: 40, width: 1, color: Colors.grey.shade400),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan["title"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: plan["done"]
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                Text(
                  plan["subtitle"],
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Text(plan["time"], style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> plans) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...plans.asMap().entries.map((entry) {
            final index = entry.key;
            final plan = entry.value;
            return _buildPlanItem(plan, isLast: index == plans.length - 1);
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Plans",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.black),
            onSelected: _changeFilter,
            itemBuilder: (context) => const [
              PopupMenuItem(value: "Daily", child: Text("Daily")),
              PopupMenuItem(value: "Weekly", child: Text("Weekly")),
              PopupMenuItem(value: "Monthly", child: Text("Monthly")),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSection("Today", todayPlans),
            _buildSection("Yesterday", yesterdayPlans),
          ],
        ),
      ),
      // ✅ external bottom nav
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
