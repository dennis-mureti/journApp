import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';
import 'package:journapp/pages/ai/aiassistant.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  int _currentIndex = 3;
  int _selectedDay = 13;
  String _selectedCategory = "Work";
  DateTime _selectedDate = DateTime.now();

  // Dummy goals data
  final List<Map<String, dynamic>> _goals = [
    {"title": "Walk 10,000 steps", "completed": true, "progress": 0.8},
    {"title": "Finish project report", "completed": false, "progress": 0.5},
    {"title": "Read 2 chapters", "completed": false, "progress": 0.2},
  ];

  // Categories data
  final List<Map<String, dynamic>> _categories = [
    {"label": "Health", "icon": Icons.favorite, "stats": "3/5 goals"},
    {"label": "Work", "icon": Icons.work, "stats": "5/8 tasks"},
    {"label": "Education", "icon": Icons.school, "stats": "2/4 courses"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Reports",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              if (value == "export") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Report exported successfully!"),
                    backgroundColor: Colors.teal,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "export", child: Text("Export")),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Month and Year Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                        _selectedDay = picked.day;
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        "${_selectedDate.month}, ${_selectedDate.year}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Days Row
            SizedBox(
              height: 72,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _dayItem("Sun", 12),
                  _dayItem("Mon", 13),
                  _dayItem("Tue", 14),
                  _dayItem("Wed", 15),
                  _dayItem("Thu", 16),
                  _dayItem("Fri", 17),
                  _dayItem("Sat", 18),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// Categories
            const Text(
              "Categories",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Wrap(
              alignment: WrapAlignment.start,
              spacing: 12,
              runSpacing: 8,
              children: _categories.map((cat) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = cat["label"];
                    });
                  },
                  child: Chip(
                    avatar: Icon(
                      cat["icon"],
                      color: _selectedCategory == cat["label"]
                          ? Colors.white
                          : Colors.black54,
                      size: 18,
                    ),
                    label: Text(
                      "${cat["label"]} (${cat["stats"]})",
                      style: TextStyle(
                        color: _selectedCategory == cat["label"]
                            ? Colors.white
                            : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    backgroundColor: _selectedCategory == cat["label"]
                        ? Colors.teal
                        : Colors.grey.shade300,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            /// Month Goals
            const Text(
              "Month Goals",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Column(
              children: _goals.map((goal) {
                return _goalCard(goal);
              }).toList(),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AiAssistantPage()),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.auto_awesome, color: Colors.white),
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

  /// Day widget
  Widget _dayItem(String day, int date) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDay = date;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Column(
          children: [
            Text(
              day,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 6),
            Container(
              width: 45,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _selectedDay == date ? Colors.teal : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _selectedDay == date
                      ? Colors.teal
                      : Colors.grey.shade400,
                ),
              ),
              child: Text(
                "$date",
                style: TextStyle(
                  color: _selectedDay == date ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Interactive Goal Card
  Widget _goalCard(Map<String, dynamic> goal) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(goal["title"]),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: goal["progress"],
              color: Colors.teal,
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 6),
            Text(
              "${(goal["progress"] * 100).toInt()}% complete",
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            goal["completed"]
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: goal["completed"] ? Colors.teal : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              goal["completed"] = !goal["completed"];
              goal["progress"] = goal["completed"] ? 1.0 : 0.0;
            });
          },
        ),
      ),
    );
  }
}
