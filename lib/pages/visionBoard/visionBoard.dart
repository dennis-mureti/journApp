import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';
import 'package:journapp/pages/visionBoard/addVisionBoard.dart';

class VisionBoardPage extends StatefulWidget {
  const VisionBoardPage({super.key});

  @override
  State<VisionBoardPage> createState() => _VisionBoardPageState();
}

class _VisionBoardPageState extends State<VisionBoardPage> {
  int _currentIndex = 3;

  // Example image list (replace with your assets or network images)
  final List<String> images = [
    "assets/Book.png",
    "assets/family.png",
    "assets/party.png",
    "assets/car.png",
    "assets/passport.png",
    "assets/forest.png",
    "assets/cross.png",
    "assets/baby.png",
    "assets/money.png",
    "assets/gym.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Vision Board",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.black),
            onSelected: (value) {
              if (value == "collection") {
                // TODO: Handle "My Collection"
              } else if (value == "share") {
                // TODO: Handle "Share"
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "collection",
                child: Text("My Collection"),
              ),
              const PopupMenuItem(value: "share", child: Text("Share")),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(images[index], fit: BoxFit.cover),
            );
          },
        ),
      ),

      // Floating Action Buttons (edit + add)
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "edit",
            mini: true,
            backgroundColor: Colors.green.shade200,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateVisionBoardPage(),
                ),
              );
            },
            child: const Icon(Icons.edit, color: Colors.black),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "add",
            backgroundColor: Colors.green.shade400,
            onPressed: () {
              // TODO: handle add
            },
            child: const Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),

      // ✅ External Custom Bottom Navigation Bar
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
