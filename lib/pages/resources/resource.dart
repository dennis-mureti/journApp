import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({super.key});

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  int _currentIndex = 2;
  bool _showFree = true;

  final List<Map<String, String>> freeResources = [
    {
      "title": "Self Reflection",
      "desc":
          "Learn how to look inward, understand your thoughts, and grow through journaling prompts.",
      "image": "assets/reflection.png",
    },
    {
      "title": "Mental Health Tips",
      "desc":
          "Practical advice and guidance to manage stress, anxiety, and emotional well-being.",
      "image": "assets/mental.png",
    },
    {
      "title": "Mindfulness",
      "desc":
          "Techniques to help you stay present, calm your mind, and develop self-awareness.",
      "image": "assets/mindfulness.png",
    },
    {
      "title": "Goal Setting",
      "desc":
          "Tools and motivation to set, track, and achieve personal and professional goals.",
      "image": "assets/goal.png",
    },
    {
      "title": "Sleep & Dreams",
      "desc":
          "Understand how sleep affects your mind and explore your dreams for deeper insights.",
      "image": "assets/sleep.png",
    },
    {
      "title": "Well-being & Health",
      "desc":
          "Holistic resources that support your physical, emotional, and mental health.",
      "image": "assets/health.png",
    },
    {
      "title": "Moon Cycle",
      "desc":
          "Explore how moon phases influence emotions, energy, and intentions.",
      "image": "assets/moon.png",
    },
    {
      "title": "Energy & Motivation",
      "desc":
          "Understand your energy highs and lows, and work with your natural rhythm.",
      "image": "assets/energy.png",
    },
  ];

  final List<Map<String, String>> paidResources = [
    {
      "title": "1-on-1 Coaching",
      "desc": "Personalized sessions with wellness coaches to help you grow.",
      "image": "assets/coaching.png",
    },
    {
      "title": "Exclusive Masterclasses",
      "desc":
          "In-depth learning sessions with experts on mindfulness, health, and more.",
      "image": "assets/masterclass.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final resources = _showFree ? freeResources : paidResources;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Resources",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          // Free / Paid toggle
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _showFree = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _showFree ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: _showFree
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Free",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _showFree = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: !_showFree ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: !_showFree
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Paid",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Resource list
          Expanded(
            child: ListView.separated(
              itemCount: resources.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final res = resources[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(res["image"]!),
                        radius: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              res["title"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              res["desc"]!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (!_showFree)
                        const Icon(
                          Icons.attach_money,
                          color: Colors.black54,
                          size: 18,
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Bottom navigation
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
}
