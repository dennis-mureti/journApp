import 'package:flutter/material.dart';
import 'package:journapp/pages/community/community.dart';
import 'package:journapp/pages/discover/discover.dart';
import 'package:journapp/pages/home/home.dart';
import 'package:journapp/pages/myspace/mySpace.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 5, 102, 102),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              label: "Today",
              icon: Icons.today,
              isSelected: currentIndex == 0,
              onTap: () {
                onTap(0); // still update the index
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            _NavItem(
              label: "Discover",
              icon: Icons.explore,
              isSelected: currentIndex == 1,
              onTap: () {
                onTap(1); // still update the index
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DiscoverPage()),
                );
              },
            ),
      
            // 🔹 Central Home Button (slightly larger to emphasize importance)
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) => const HomePage()),
            //     );
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.all(8),
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: currentIndex == 2
            //           ? Colors.black.withOpacity(0.1)
            //           : Colors.transparent,
            //     ),
            //     child: const Icon(Icons.home, size: 28, color: Colors.black),
            //   ),
            // ),
            _NavItem(
              label: "Community",
              icon: Icons.group,
              isSelected: currentIndex == 2,
              onTap: () {
                onTap(2); // still update the index
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CommunityPage()),
                );
              },
            ),
      
            _NavItem(
              label: "My Space",
              icon: Icons.person,
              isSelected: currentIndex == 3,
              onTap: () {
                onTap(3); // still update the index
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MySpacePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // larger tap target
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 22,
            color: isSelected ? Colors.black : Colors.black.withOpacity(0.6),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.black.withOpacity(0.6),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 2),
              height: 2,
              width: 24,
              color: Colors.black,
            ),
        ],
      ),
    );
  }
}
