import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journapp/common/bottomNavigationBar.dart';

class FreeJournalPage extends StatefulWidget {
  const FreeJournalPage({super.key});

  @override
  State<FreeJournalPage> createState() => _FreeJournalPageState();
}

class _FreeJournalPageState extends State<FreeJournalPage> {
  final TextEditingController journalController = TextEditingController();
  int _currentIndex = 0;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    journalController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

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
          "Free Journal",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Stack(
                  children: [
                    TextField(
                      controller: journalController,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write your thoughts here...",
                      ),
                    ),

                    // Preview image if selected
                    if (_selectedImage != null)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _selectedImage!,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    // Bottom icons
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: IconButton(
                        icon: const Icon(
                          Icons.image,
                          color: Colors.black,
                          size: 28,
                        ),
                        onPressed: _pickImage,
                      ),
                    ),
                    const Positioned(
                      bottom: 8,
                      right: 56,
                      child: Icon(Icons.transcribe, color: Colors.black, size: 28),
                    ),
                    const Positioned(
                      bottom: 8,
                      right: 8,
                      child: Icon(
                        Icons.picture_as_pdf,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Save logic (journalController.text + _selectedImage)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[400],
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6, // <-- adds shadow
                shadowColor: Colors.black.withOpacity(
                  1,
                ), // optional for custom shadow
              ),
              child: const Text("Save thought"),
            ),
          ],
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
}
