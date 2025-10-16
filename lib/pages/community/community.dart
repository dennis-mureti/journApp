import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';
import 'package:journapp/pages/profile/profile.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _currentIndex = 2;
  String _searchQuery = '';

  final List<Map<String, dynamic>> posts = [
    {
      "user": "Anna",
      "avatar": "assets/user1.png",
      "text": "Today's challenge: 10 minutes mindful breathing 🧘‍♀️",
      "likes": 24,
      "liked": false,
      "comments": [
        {"user": "Brian", "text": "Tried it — felt amazing!"},
        {"user": "Cathy", "text": "Love this challenge!"},
      ],
      "isReported": false,
    },
    {
      "user": "Brian",
      "avatar": "assets/user2.png",
      "text": "💪 Day 3 of exercise challenge complete!",
      "likes": 35,
      "liked": false,
      "comments": [],
      "isReported": false,
    },
  ];

  final List<Map<String, String>> categories = [
    {"title": "NUTRITION", "image": "assets/nut.png"},
    {"title": "BREATHING", "image": "assets/bre.png"},
    {"title": "MENSTRUAL", "image": "assets/mnt.png"},
    {"title": "EXERCISE", "image": "assets/exr.png"},
    {"title": "SEXUALITY", "image": "assets/sex.png"},
    {"title": "COACHING", "image": "assets/coa.png"},
    {"title": "SLEEP", "image": "assets/slp.png"},
    {"title": "WRITING", "image": "assets/wrt.png"},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCategories = categories
        .where(
          (c) => c["title"]!.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();

    final isSearching = _searchQuery.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Community",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 🔍 Search bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: const InputDecoration(
                  hintText: "Search categories, users, or posts...",
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search, color: Colors.black54),
                ),
              ),
            ),
            const SizedBox(height: 20),

            if (!isSearching) ...[
              const Text(
                "Community Challenges",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _challengeCard(
                      "Mindful Breathing",
                      0.6,
                      "3 days left",
                      "assets/bre.png",
                    ),
                    _challengeCard(
                      "Sleep Tracker",
                      0.4,
                      "5 days left",
                      "assets/slp.png",
                    ),
                    _challengeCard(
                      "Gratitude Journal",
                      0.8,
                      "2 days left",
                      "assets/ref.png",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Latest Posts",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              if (posts.isEmpty)
                const Center(
                  child: Text("No posts yet, be the first to share ✨"),
                ),
              ...posts.map((p) => _postCard(p)).toList(),
              const SizedBox(height: 20),
            ],

            // 📂 Categories
            Text(
              isSearching ? "Search Results" : "Explore Categories",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            if (filteredCategories.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text("No matching categories found 😕"),
                ),
              )
            else
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredCategories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.4,
                    ),
                    itemBuilder: (context, index) {
                      final category = filteredCategories[index];
                      return GestureDetector(
                        onTapDown: (_) => setState(() {}),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Opening ${category['title']}..."),
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              CircleAvatar(
                                backgroundImage: AssetImage(category["image"]!),
                                radius: 22,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  category["title"]!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }

  // 🏅 Challenge Card with progress bar
  Widget _challengeCard(
    String title,
    double progress,
    String subtitle,
    String img,
  ) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundImage: AssetImage(img), radius: 22),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: progress,
              color: Colors.teal,
              backgroundColor: Colors.teal[100],
            ),
          ],
        ),
      ),
    );
  }

  // 💬 Post Card
  Widget _postCard(Map<String, dynamic> post) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage(post["avatar"])),
              const SizedBox(width: 10),
              Text(
                post["user"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.flag, color: Colors.redAccent, size: 20),
                onPressed: () {
                  setState(() => post["isReported"] = true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Post reported for review")),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(post["text"]),
          const SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    post["liked"] = !post["liked"];
                    post["likes"] += post["liked"] ? 1 : -1;
                  });
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    post["liked"] ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(post["liked"]),
                    color: post["liked"] ? Colors.redAccent : Colors.black54,
                  ),
                ),
              ),
              Text("${post["likes"]}"),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.comment_outlined),
                onPressed: () => _showComments(post),
              ),
              Text("${post["comments"].length}"),
            ],
          ),
        ],
      ),
    );
  }

  // 💬 Comment Bottom Sheet
  void _showComments(Map<String, dynamic> post) {
    final commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    const Text(
                      "Comments",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: post["comments"].length,
                        itemBuilder: (context, index) {
                          final c = post["comments"][index];
                          return ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(c["user"]),
                            subtitle: Text(c["text"]),
                          );
                        },
                      ),
                    ),
                    TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: "Add a comment...",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (commentController.text.isNotEmpty) {
                              setModalState(() {
                                post["comments"].add({
                                  "user": "You",
                                  "text": commentController.text,
                                });
                              });
                              commentController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
