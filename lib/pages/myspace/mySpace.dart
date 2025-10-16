import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journapp/common/bottomNavigationBar.dart';
import 'package:journapp/pages/goal/myGoals.dart';
import 'package:journapp/pages/journal/journalArchivePage.dart';
import 'package:journapp/pages/plan/myPlan.dart';
import 'package:journapp/pages/report/reportPage.dart';
import 'package:journapp/pages/visionBoard/visionBoard.dart'; // For HapticFeedback

class MySpacePage extends StatefulWidget {
  const MySpacePage({super.key});

  @override
  State<MySpacePage> createState() => _MySpacePageState();
}

class _MySpacePageState extends State<MySpacePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 3;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final Map<String, Map<String, dynamic>> _sections = {
    'My Goals': {
      'icon': Icons.flag_outlined,
      'color': const Color(0xFF1A669C).withValues(),
      'page': const MyGoalsPage(),
    },
    'My Plans': {
      'icon': Icons.calendar_today_outlined,
      'color': Colors.grey[300]!,
      'page': const MyPlanPage(),
    },
    'My Reports': {
      'icon': Icons.bar_chart_outlined,
      'color': const Color(0xFF1A669C).withValues(),
      'page': const ReportsPage(),
    },
    'My Story': {
      'icon': Icons.book_outlined,
      'color': Colors.grey[300]!,
      'page': const JournalArchivePage(),
    },
    'Vision Board': {
      'icon': Icons.dashboard_outlined,
      'color': Colors.grey[300]!,
      'page': const VisionBoardPage(),
    },
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateTo(Widget page) {
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
        title: const Text(
          'My Space',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: _showSearch,
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              _buildSearchBar(),
              const SizedBox(height: 24),

              // Main sections
              ..._buildSectionList(_sections.keys.take(3).toList()),

              // Bottom sections in a row
              Row(
                children: [
                  Expanded(
                    child: _buildSectionCard(_sections.keys.elementAt(3)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSectionCard(_sections.keys.elementAt(4)),
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
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search in My Space...",
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: Colors.black54),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onChanged: (value) {
          // Implement search functionality
        },
      ),
    );
  }

  List<Widget> _buildSectionList(List<String> sectionTitles) {
    return sectionTitles
        .map(
          (title) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildSectionCard(title),
          ),
        )
        .toList();
  }

  Widget _buildSectionCard(String title) {
    final section = _sections[title]!;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          HapticFeedback.lightImpact();
          _navigateTo(section['page'] as Widget);
        },
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: section['color'] as Color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Icon on top-left
              Positioned(
                top: 16,
                left: 16,
                child: Icon(
                  section['icon'] as IconData,
                  size: 32,
                  color: Colors.black87,
                ),
              ),
              // Title at bottom-left
              Positioned(
                bottom: 16,
                left: 16,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              // Forward arrow on right side
              const Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearch() {
    // Implement search functionality
    showSearch(context: context, delegate: _JournalSearchDelegate(_sections));
  }
}

class _JournalSearchDelegate extends SearchDelegate<String> {
  final Map<String, Map<String, dynamic>> sections;

  _JournalSearchDelegate(this.sections);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults();

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults();

  Widget _buildSearchResults() {
    final results = query.isEmpty
        ? sections.entries.toList()
        : sections.entries
              .where((e) => e.key.toLowerCase().contains(query.toLowerCase()))
              .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final section = results[index];
        return ListTile(
          leading: Icon(section.value['icon'] as IconData),
          title: Text(section.key),
          onTap: () {
            close(context, section.key);
            // Navigation would be handled by the parent widget
          },
        );
      },
    );
  }
}
