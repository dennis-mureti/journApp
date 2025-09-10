import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journapp/common/bottomNavigationBar.dart';
import 'package:journapp/pages/goal/addGoal.dart';
// import 'custom_bottom_nav_bar.dart';

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
                  // Handle logout
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
                // Navigator.push(
                //   // context,
                //   // MaterialPageRoute(
                //   //   builder: (context) => const TrackEnergyPage(),
                //   // ), // <-- replace with your page
                // );
              } else if (value == "mood") {
                // Navigator.push(
                //   // context,
                //   // MaterialPageRoute(
                //   //   builder: (context) => const TrackMoodPage(),
                //   // ), // <-- replace with your page
                // );
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
                        border: InputBorder.none, // remove outline
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
                    // Handle add goal
                    Get.toNamed('/addGoal');
                  },
                  mini: true,
                  child: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Reminder
            const Text(
              "Reminder",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
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
                controller: reminderController,
                decoration: const InputDecoration(
                  hintText: "What will you Nurture today ?",
                  border: InputBorder.none, // remove border
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // My Health
            const Text(
              "My Health",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                _HealthCard(icon: Icons.sentiment_satisfied, label: "Mood"),
                SizedBox(width: 8),
                _HealthCard(icon: Icons.bolt, label: "Energy"),
                SizedBox(width: 8),
                _HealthCard(icon: Icons.bed, label: "Sleep"),
              ],
            ),
            const SizedBox(height: 20),

            // Track
            Container(
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
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Track",
                  border: InputBorder.none, // removes the outline border
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
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

      // ✅ Use external CustomBottomNavBar
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

  const _HealthCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
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
      ),
    );
  }
}
