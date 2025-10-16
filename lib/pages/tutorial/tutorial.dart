import 'dart:math';
import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  bool _isPlaying = true;
  double _progress = 0.3;
  int _currentIndex = 3;
  int _currentStep = 0;
  late Color _headerColor = Colors.teal.shade50;

  final List<Color> _pastelColors = [
    Colors.pinkAccent.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.teal.shade100,
    Colors.amber.shade100,
  ];

  final List<Map<String, String>> _steps = [
    {
      'title': 'Welcome to JournApp 🌿',
      'desc':
          'Your personal space for mindfulness and self-discovery. JournApp helps you reflect and reconnect with yourself daily.',
    },
    {
      'title': 'Track Your Moods 😊',
      'desc':
          'Monitor emotional patterns and habits over time to gain clarity and balance in your everyday life.',
    },
    {
      'title': 'Set Personal Goals 🎯',
      'desc':
          'Stay motivated and consistent by setting goals and tracking progress through meaningful journaling prompts.',
    },
    {
      'title': 'Reflect and Grow 🌙',
      'desc':
          'Look back on your entries, spot trends, and grow through self-awareness and insights.',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _headerColor = _pastelColors[Random().nextInt(_pastelColors.length)];
      });
    });
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    } else {
      _showCompletionDialog();
    }
  }

  void _skipTutorial() {
    _showCompletionDialog(skipped: true);
  }

  void _showCompletionDialog({bool skipped = false}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          skipped ? "Tutorial Skipped" : "Tutorial Complete 🎉",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          skipped
              ? "You’ve skipped the introduction. You can revisit it anytime in the Help section."
              : "Great job! You’ve completed the JournApp walkthrough.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Got it"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final step = _steps[_currentStep];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Tutorial",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
        actions: [
          TextButton(
            onPressed: _skipTutorial,
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: isLargeScreen ? screenWidth * 0.15 : 20,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Progress Indicator
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _steps.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 10,
                    width: index == _currentStep ? 30 : 10,
                    decoration: BoxDecoration(
                      color: index <= _currentStep
                          ? Colors.teal
                          : Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            // Step Content
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: _headerColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title']!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    step['desc']!,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Next Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _nextStep,
              child: Text(
                _currentStep == _steps.length - 1 ? "Finish" : "Next",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),

            // Optional: play narration section (kept from your previous version)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Prefer listening instead?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Tap play to hear an introduction to how JournApp supports your wellbeing.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.5, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),

                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6,
                      ),
                    ),
                    child: Slider(
                      activeColor: Colors.teal,
                      inactiveColor: Colors.teal.shade100,
                      value: _progress,
                      onChanged: (value) {
                        setState(() {
                          _progress = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "00:16",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      Text(
                        "02:48",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildControlIcon(Icons.replay_10),
                      _buildControlIcon(Icons.fast_rewind_rounded),
                      _buildPlayPauseButton(),
                      _buildControlIcon(Icons.fast_forward_rounded),
                      _buildControlIcon(Icons.volume_up_rounded),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
        ),
      ),
    );
  }

  static Widget _buildControlIcon(IconData icon) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 28, color: Colors.black87),
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => setState(() => _isPlaying = !_isPlaying),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isPlaying ? Colors.teal : Colors.teal.shade300,
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
