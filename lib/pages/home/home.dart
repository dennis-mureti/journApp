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
  // Controllers
  final TextEditingController goalController = TextEditingController();
  final TextEditingController nurtureController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();

  // Nav
  int _currentIndex = 0;

  // personalization and state
  String userName = "Dennis"; // replace with dynamic user value later
  int journalStreak = 5; // mock streak value; replace with real logic later

  // sample upcoming reminders (replace with real data)
  final List<Map<String, String>> _reminders = [
    {"title": "Evening Reflection", "time": "Tonight • 9:00 PM"},
    {"title": "Meditation Session", "time": "Tomorrow • 7:00 AM"},
    {"title": "Hydration Reminder", "time": "Today • 4:00 PM"},
  ];

  @override
  void dispose() {
    goalController.dispose();
    nurtureController.dispose();
    reminderController.dispose();
    super.dispose();
  }

  // Mood modal (enhanced emoji UI)
  void _showMoodModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        int selectedValue = 7; // slider value
        String selectedEmoji = "🙂"; // default emoji
        final moods = [
          {"emoji": "😡", "label": "Angry"},
          {"emoji": "😞", "label": "Sad"},
          {"emoji": "😐", "label": "Neutral"},
          {"emoji": "😊", "label": "Happy"},
          {"emoji": "🤩", "label": "Excited"},
        ];

        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  top: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Mood",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat.Hm().format(DateTime.now()),
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("How are your emotions today?"),
                    ),
                    const SizedBox(height: 12),

                    // Emoji selector row
                    Wrap(
                      spacing: 12,
                      children: moods.map((m) {
                        final isSelected = selectedEmoji == m["emoji"];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedEmoji = m["emoji"]!;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.teal.shade100
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: isSelected
                                  ? Border.all(color: Colors.teal, width: 1.5)
                                  : null,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  m["emoji"]!,
                                  style: const TextStyle(fontSize: 30),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  m["label"]!,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 18),

                    // Slider for nuance
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

                    const SizedBox(height: 8),
                    Text(
                      "Selected mood: $selectedEmoji  •  Intensity: $selectedValue",
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Mood entry canceled"),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: persist mood + intensity
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Saved mood $selectedEmoji (intensity $selectedValue)",
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------
  // Energy modal (kept)
  // ---------------------------
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
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Energy",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat.Hm().format(DateTime.now()),
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("How energized are you?"),
                    ),
                    const SizedBox(height: 12),
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
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("😴"),
                        Text("🥱"),
                        Text("😐"),
                        Text("🙂"),
                        Text("⚡"),
                      ],
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Saved energy level ($selectedValue)",
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Sleep modal (kept)
  void _showSleepModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        double sleepHours = 7;
        String sleepQuality = "Good";
        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Sleep",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat.Hm().format(DateTime.now()),
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("How many hours did you sleep?"),
                    ),
                    Slider(
                      value: sleepHours,
                      min: 0,
                      max: 12,
                      divisions: 12,
                      label: "${sleepHours.round()} hrs",
                      onChanged: (val) => setState(() => sleepHours = val),
                    ),
                    Text("~${sleepHours.round()} hours"),
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("How was the quality of your sleep?"),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
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
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Saved sleep: ${sleepHours.round()} hrs, $sleepQuality",
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------
  // Greeting header widget
  // ---------------------------
  Widget _greetingSection() {
    final hour = DateTime.now().hour;
    String greeting = "Good Morning";
    if (hour >= 12 && hour < 17) greeting = "Good Afternoon";
    if (hour >= 17) greeting = "Good Evening";

    final dateStr = DateFormat('EEEE, MMM d').format(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$greeting, $userName 👋",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(dateStr, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

  // ---------------------------
  // Streak widget
  // ---------------------------
  Widget _streakWidget() {
    // simple progress visualization (out of 7 days)
    final double progress = (journalStreak.clamp(0, 7)) / 7;
    return Card(
      color: Colors.teal.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            const Icon(Icons.local_fire_department, color: Colors.orange),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🔥 $journalStreak-day streak",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      color: Colors.orange,
                      backgroundColor: Colors.orange.shade100,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.grey),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Keep journaling daily to maintain and grow your streak!",
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------
  // Daily quote / affirmation widget
  // ---------------------------
  Widget _quoteWidget() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text(
              "✨ “The most difficult thing is the decision to act; the rest is merely tenacity.”",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8),
            Text("– Amelia Earhart", style: TextStyle(color: Colors.black54)),
            SizedBox(height: 8),
            Text(
              "💬 Affirmation: I take small steps every day toward a more mindful life.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------
  // Upcoming events / reminders widget
  // ---------------------------
  Widget _upcomingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upcoming Reminders",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          children: _reminders.map((r) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 1.5,
              child: ListTile(
                leading: const Icon(Icons.notifications, color: Colors.teal),
                title: Text(r["title"]!),
                subtitle: Text(r["time"]!),
                trailing: IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Reminder: ${r["title"]}")),
                    );
                  },
                ),
                onTap: () {
                  // TODO: navigate to reminder detail or edit
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ---------------------------
  // Quick Journal action
  // ---------------------------
  void _openQuickJournal() {
    // keep existing behavior — navigate to quick journal route (replace with actual)
    Get.toNamed('/journal');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: const Icon(Icons.filter_list, color: Colors.black),
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting + date
            _greetingSection(),
            const SizedBox(height: 12),

            // Streak
            _streakWidget(),
            const SizedBox(height: 16),

            // Quote & affirmation
            _quoteWidget(),
            const SizedBox(height: 16),

            // Quick Journal Button (keeps existing UI behavior)
            ElevatedButton.icon(
              onPressed: _openQuickJournal,
              icon: const Icon(Icons.note_add),
              label: const Text("Quick Journal"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Upcoming reminders
            _upcomingSection(),
            const SizedBox(height: 16),

            // Goal input (keeps behavior)
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
                          color: Colors.black.withOpacity(0.06),
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

            const SizedBox(height: 16),

            // Reminder banner (keeps behavior)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade300, width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.notifications_active, color: Colors.orange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Reminder: Don't forget to track your mood and energy today!",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Nurture input (separate controller to avoid reuse bug)
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: nurtureController,
                      decoration: const InputDecoration(
                        hintText: "What will you nurture today ?",
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
                    // keep same navigation
                    Get.toNamed('/addGoal');
                  },
                  mini: true,
                  child: const Icon(Icons.check),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // My Health section (keeps cards and behavior)
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

            // Track module kept
            GestureDetector(
              onTap: () {
                Get.toNamed('/myPlan');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
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

            // Journaling button kept
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

            const SizedBox(height: 60), // spacing bottom
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

      // Bottom nav kept (external)
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
