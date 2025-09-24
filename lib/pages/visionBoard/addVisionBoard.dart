import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journapp/common/bottomNavigationBar.dart';

class CreateVisionBoardPage extends StatefulWidget {
  const CreateVisionBoardPage({super.key});

  @override
  State<CreateVisionBoardPage> createState() => _CreateVisionBoardPageState();
}

class _CreateVisionBoardPageState extends State<CreateVisionBoardPage> {
  final ImagePicker _picker = ImagePicker();

  /// Holds vision board items (can be colors or images)
  final List<dynamic> visionBoardItems = [
    Colors.grey.shade300,
    Colors.grey.shade400,
    Colors.grey.shade300,
    Colors.grey.shade400,
    Colors.grey.shade300,
    Colors.grey.shade400,
    Colors.grey.shade300,
  ];

  int _currentIndex = 3;

  /// Open camera and add captured image to the grid
  Future<void> _openCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        visionBoardItems.insert(0, File(photo.path)); // add new photo at top
      });
    }
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
          "Vision Board",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Menu tapped")));
            },
          ),
        ],
      ),

      /// Vision Board grid
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: visionBoardItems.length,
          itemBuilder: (context, index) {
            final item = visionBoardItems[index];

            if (item is Color) {
              return Container(
                height: (index % 4 + 1) * 80,
                decoration: BoxDecoration(
                  color: item,
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            } else if (item is File) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(item, fit: BoxFit.cover),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),

      /// Floating action button (camera)
      floatingActionButton: FloatingActionButton(
        heroTag: "camera",
        backgroundColor: Colors.green.shade300,
        onPressed: _openCamera,
        child: const Icon(Icons.camera_alt, color: Colors.black),
      ),

      /// Bottom navigation (external widget)
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
