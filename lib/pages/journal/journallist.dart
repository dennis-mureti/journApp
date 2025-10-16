import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For HapticFeedback
import 'package:journapp/common/bottomNavigationBar.dart';
import 'package:journapp/pages/journal/journal.dart';
import 'package:journapp/pages/journal/promptjournal.dart';
import 'package:journapp/pages/visionBoard/visionBoard.dart';

class JournalListPage extends StatefulWidget {
  const JournalListPage({super.key});

  @override
  State<JournalListPage> createState() => _JournalListPageState();
}

class _JournalListPageState extends State<JournalListPage> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredJournals = [];

  final List<Map<String, dynamic>> _allJournals = [
    {
      "title": "Vision Board",
      "color": Colors.pink[100],
      "count": 5,
      "lastUpdated": "Today",
    },
    {
      "title": "Journal",
      "color": Colors.orange[100],
      "count": 12,
      "lastUpdated": "2h ago",
    },
    {
      "title": "Prompt Journaling",
      "color": Colors.green[100],
      "count": 8,
      "lastUpdated": "Yesterday",
    },
    {
      "title": "Gratitude Log",
      "color": Colors.lightBlue[100],
      "count": 15,
      "lastUpdated": "Today",
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredJournals = List.from(_allJournals);
    _searchController.addListener(_filterJournals);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterJournals() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredJournals = _allJournals
          .where((journal) => journal["title"].toLowerCase().contains(query))
          .toList();
    });
  }

  void _navigateToPage(Widget page) {
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeInOut));
          return FadeTransition(opacity: animation.drive(tween), child: child);
        },
      ),
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
          "Journal Section",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              showSearch(
                context: context,
                delegate: JournalSearchDelegate(_allJournals),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onSelected: (value) {
              if (value == "goal") {
                Navigator.pushNamed(context, "/addGoal");
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "goal", child: Text("Add Goal")),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search journals...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredJournals.length,
              itemBuilder: (context, index) {
                final journal = _filteredJournals[index];
                return _buildJournalCard(journal, context);
              },
            ),
          ),
        ],
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

  Widget _buildJournalCard(Map<String, dynamic> journal, BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        if (journal["title"] == "Journal") {
          _navigateToPage(const FreeJournalPage());
        } else if (journal["title"] == "Prompt Journaling") {
          _navigateToPage(const PromptJournalPage());
        } else if (journal["title"] == "Vision Board") {
          _navigateToPage(const VisionBoardPage());
        }
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(minHeight: 100, maxHeight: 140),
          decoration: BoxDecoration(
            color: journal["color"],
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    journal["title"],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${journal["count"]} entries",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Last updated: ${journal["lastUpdated"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JournalSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> journals;

  JournalSearchDelegate(this.journals);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = journals
        .where(
          (journal) =>
              journal["title"].toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final journal = results[index];
        return ListTile(
          title: Text(journal["title"]),
          onTap: () {
            // Handle journal selection
            close(context, journal);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : journals
              .where(
                (journal) => journal["title"].toLowerCase().contains(
                  query.toLowerCase(),
                ),
              )
              .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final journal = suggestions[index];
        return ListTile(
          title: Text(journal["title"]),
          onTap: () {
            query = journal["title"];
            showResults(context);
          },
        );
      },
    );
  }
}
