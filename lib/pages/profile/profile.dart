import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journapp/common/bottomNavigationBar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController languageController = TextEditingController();

  bool notifications = false;
  bool biometrics = false;
  String subscription = "Premium";

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 4,
        onTap: (index) {
          // handle bottom nav tap
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.black),
            itemBuilder: (context) => [
              const PopupMenuItem(value: "story", child: Text("My Story")),
              const PopupMenuItem(value: "resources", child: Text("Resources")),
              const PopupMenuItem(value: "about", child: Text("About")),
            ],
            onSelected: (value) {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // Profile Image + edit button
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage("assets/profileImage.png"),
                ),
                FloatingActionButton.small(
                  onPressed: _pickImage,
                  backgroundColor: Colors.white,
                  elevation: 2,
                  child: const Icon(Icons.edit, size: 20, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // First Name
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "First Name",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(
                hintText: "Jane",
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
            const Divider(),

            // Last Name
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Last Name",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: "Doe",
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
            const Divider(),

            // Username
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Username",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: "joedoe89",
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
            const Divider(),

            // Email
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "joedoe89@gmail.com",
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
            const Divider(),

            // Language
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Language",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            TextFormField(
              controller: languageController,
              decoration: const InputDecoration(
                hintText: "English",
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
            const Divider(),

            const SizedBox(height: 16),

            // Notifications Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Notifications",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Switch(
                  value: notifications,
                  onChanged: (val) {
                    setState(() => notifications = val);
                  },
                ),
              ],
            ),
            const Divider(),

            // Biometrics Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Biometrics",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Switch(
                  value: biometrics,
                  onChanged: (val) {
                    setState(() => biometrics = val);
                  },
                ),
              ],
            ),
            const Divider(),

            const SizedBox(height: 16),

            // Subscription Dropdown
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Subscription",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            DropdownButtonFormField<String>(
              value: subscription,
              items: const [
                DropdownMenuItem(value: "Free", child: Text("Free")),
                DropdownMenuItem(value: "Premium", child: Text("Premium")),
                DropdownMenuItem(
                  value: "Enterprise",
                  child: Text("Enterprise"),
                ),
              ],
              onChanged: (value) {
                setState(() => subscription = value!);
              },
              decoration: const InputDecoration(border: InputBorder.none),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
