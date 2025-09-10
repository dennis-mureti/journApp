import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';

class AddGoalPage extends StatefulWidget {
  const AddGoalPage({super.key});

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  String? selectedFrequency;
  String? selectedColor;

  final List<String> frequencies = [
    "Every day",
    "3 times a week",
    "Once a week",
  ];

  final List<String> colors = ["Red", "Green", "Blue", "Cream"];
  int _currentIndex = 0;

  // Reusable input decoration with shadow
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  Widget _shadowContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Goals",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.menu, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/g.png", // replace with your asset
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Save button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Current Goal
            const Text("Current Goal"),
            const SizedBox(height: 6),
            _shadowContainer(
              child: TextField(
                decoration: _inputDecoration("Enter your goal title"),
              ),
            ),
            const SizedBox(height: 16),

            // Describe Goal
            const Text("Describe Goal"),
            const SizedBox(height: 6),
            _shadowContainer(
              child: TextField(
                maxLines: 3,
                decoration: _inputDecoration("Add Description"),
              ),
            ),
            const SizedBox(height: 16),

            // Frequency
            const Text("Frequency and Reminder"),
            const SizedBox(height: 6),
            _shadowContainer(
              child: DropdownButtonFormField<String>(
                value: selectedFrequency,
                items: frequencies
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFrequency = value;
                  });
                },
                decoration: _inputDecoration("Select frequency"),
              ),
            ),
            const SizedBox(height: 16),

            // Tile color
            const Text("Tile color"),
            const SizedBox(height: 6),
            _shadowContainer(
              child: DropdownButtonFormField<String>(
                value: selectedColor,
                items: colors
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedColor = value;
                  });
                },
                decoration: _inputDecoration("Select color"),
              ),
            ),
            const SizedBox(height: 16),

            // Progress
            _shadowContainer(
              child: TextField(decoration: _inputDecoration("Progress")),
            ),
            const SizedBox(height: 20),

            // Delete button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {},
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Use the existing custom nav bar
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
