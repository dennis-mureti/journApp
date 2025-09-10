import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';

class MySpacePage extends StatefulWidget {
  const MySpacePage({super.key});

  @override
  State<MySpacePage> createState() => _MySpacePageState();
}

class _MySpacePageState extends State<MySpacePage> {
  int _currentIndex = 3; // My Space is selected by default (index 3)

  // Define colors for each card
  final Map<String, Color> cardColors = {
    'My Goals': const Color.fromARGB(255, 26, 102, 156),
    'My Plans': const Color.fromARGB(255, 173, 173, 173),
    'My Reports': Color.fromARGB(255, 26, 102, 156),
    'My Story': Color.fromARGB(255, 173, 173, 173),
    'Vision Board': Color.fromARGB(255, 173, 173, 173),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Space',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () {
        //       // Handle search action
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search, color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // My Goals section
              _buildSection(
                'My Goals',
                Icons.flag_outlined,
                cardColors['My Goals']!,
              ),
              const SizedBox(height: 16),

              // My Plans section
              _buildSection(
                'My Plans',
                Icons.calendar_today_outlined,
                cardColors['My Plans']!,
              ),
              const SizedBox(height: 16),

              // My Reports section
              _buildSection(
                'My Reports',
                Icons.bar_chart_outlined,
                cardColors['My Reports']!,
              ),
              const SizedBox(height: 16),

              // My Story and Vision Board in a row
              Row(
                children: [
                  Expanded(
                    child: _buildSection(
                      'My Story',
                      Icons.book_outlined,
                      cardColors['My Story']!,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSection(
                      'Vision Board',
                      Icons.dashboard_outlined,
                      cardColors['Vision Board']!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
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

  Widget _buildSection(String title, IconData icon, Color cardColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 120, // Increased card height
        width: double.infinity,
        decoration: BoxDecoration(
          color: cardColor, // Custom card color
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          leading: Icon(icon, size: 32), // Larger icon
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Handle section tap
            _showSectionDialog(context, title);
          },
        ),
      ),
    );
  }

  void _showSectionDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('$title content would appear here.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
