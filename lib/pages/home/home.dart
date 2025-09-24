import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journapp/common/bottomNavigationBar.dart';
import 'package:journapp/pages/ai/aiassistant.dart';
import 'package:journapp/pages/goal/addGoal.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController goalController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();
  int _currentIndex = 0;

  @override
  void dispose() {
    goalController.dispose();
    reminderController.dispose();
    super.dispose();
  }

  // ✅ Mood Modal
  void _showMoodModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        int selectedValue = 7; // default mood scale

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Mood",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Time row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat.Hm().format(
                          DateTime.now(),
                        ), // shows current time in 24h format
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  const Text("How are your emotions and mood today?"),
                  const SizedBox(height: 12),

                  // Slider for mood
                  Slider(
                    value: selectedValue.toDouble(),
                    min: 1,
                    max: 13,
                    divisions: 12,
                    label: "$selectedValue",
                    onChanged: (val) {
                      setState(() {
                        selectedValue = val.toInt();
                      });
                    },
                  ),

                  // Emoji row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("😡"),
                      Text("😔"),
                      Text("😐"),
                      Text("🙂"),
                      Text("😁"),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Text("How are you feeling?"),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // close modal
                      // TODO: save mood logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                    child: const Text("Save"),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showEnergyModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        int selectedValue = 7; // default energy scale

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Energy",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Time row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat.Hm().format(
                          DateTime.now(),
                        ), // shows current time in 24h format
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  const Text("How are your energy levels today?"),
                  const SizedBox(height: 12),

                  // Slider for energy
                  Slider(
                    value: selectedValue.toDouble(),
                    min: 1,
                    max: 13,
                    divisions: 12,
                    label: "$selectedValue",
                    onChanged: (val) {
                      setState(() {
                        selectedValue = val.toInt();
                      });
                    },
                  ),

                  // Emoji row (energy vibes)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("😴"), // very low energy
                      Text("🥱"), // low
                      Text("😐"), // neutral
                      Text("🙂"), // okay
                      Text("⚡"), // full energy
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Text("How energized do you feel?"),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // close modal
                      // TODO: save energy logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                    child: const Text("Save"),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSleepModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        double sleepHours = 7; // default sleep hours
        String sleepQuality = "Good"; // default sleep quality

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Sleep",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Time row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time, size: 18),
                      const SizedBox(width: 4),
                      Text(DateFormat.Hm().format(DateTime.now())),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Text("How many hours did you sleep?"),
                  const SizedBox(height: 12),

                  // Hours slider
                  Slider(
                    value: sleepHours,
                    min: 0,
                    max: 12,
                    divisions: 12,
                    label: "${sleepHours.round()} hrs",
                    onChanged: (val) {
                      setState(() {
                        sleepHours = val;
                      });
                    },
                  ),
                  Text("~${sleepHours.round()} hours"),

                  const SizedBox(height: 20),
                  const Text("How was the quality of your sleep?"),
                  const SizedBox(height: 12),

                  // Sleep quality buttons
                  Wrap(
                    spacing: 10,
                    children: [
                      ChoiceChip(
                        label: const Text("Poor"),
                        selected: sleepQuality == "Poor",
                        onSelected: (selected) {
                          setState(() => sleepQuality = "Poor");
                        },
                      ),
                      ChoiceChip(
                        label: const Text("Fair"),
                        selected: sleepQuality == "Fair",
                        onSelected: (selected) {
                          setState(() => sleepQuality = "Fair");
                        },
                      ),
                      ChoiceChip(
                        label: const Text("Good"),
                        selected: sleepQuality == "Good",
                        onSelected: (selected) {
                          setState(() => sleepQuality = "Good");
                        },
                      ),
                      ChoiceChip(
                        label: const Text("Excellent"),
                        selected: sleepQuality == "Excellent",
                        onSelected: (selected) {
                          setState(() => sleepQuality = "Excellent");
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // close modal
                      // TODO: Save sleepHours + sleepQuality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                    child: const Text("Save"),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Side Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 50),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),

      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/moon.png', width: 28, height: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Get.toNamed('/profile');
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.black),
            onSelected: (value) {
              if (value == "goal") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddGoalPage()),
                );
              } else if (value == "energy") {
                _showEnergyModal(context);
              } else if (value == "mood") {
                _showMoodModal(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "goal", child: Text("Add Goal")),
              const PopupMenuItem(value: "energy", child: Text("Track Energy")),
              const PopupMenuItem(value: "mood", child: Text("Track Mood")),
            ],
          ),
        ],
      ),

      // Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quote card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "The most difficult thing is the decision to act; the rest is merely tenacity.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Amelia Earhart",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Goal
            const Text(
              "Goal",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: goalController,
                      decoration: const InputDecoration(
                        hintText: "Add your first goal to begin!",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    Get.toNamed('/addGoal');
                  },
                  mini: true,
                  child: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Reminder
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100, // light background for reminder
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade300, width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.notifications_active, color: Colors.orange),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      "Reminder: Don't forget to track your mood and energy today!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: goalController,
                      decoration: const InputDecoration(
                        hintText: "What will you Nurture today ?",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    Get.toNamed('/addGoal');
                  },
                  mini: true,
                  child: const Icon(Icons.check),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // My Health
            const Text(
              "My Health",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showMoodModal(context),
                    child: const _HealthCard(
                      icon: Icons.sentiment_satisfied,
                      label: "Mood",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showEnergyModal(context),
                    child: const _HealthCard(icon: Icons.bolt, label: "Energy"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showSleepModal(context),
                    child: const _HealthCard(icon: Icons.bed, label: "Sleep"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Track
            GestureDetector(
              onTap: () {
                Get.toNamed('/myPlan');
                // 👉 Open a modal or navigate
                // Example: _showTrackModal(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Track",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Journaling
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/journalList');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Journaling"),
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

      // ✅ Custom BottomNavBar
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

class _HealthCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HealthCard({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.grey[700]),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
