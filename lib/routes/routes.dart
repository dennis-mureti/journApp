import 'package:get/get.dart';
import 'package:journapp/pages/ai/aiassistant.dart';
import 'package:journapp/pages/discover/discover.dart';
import 'package:journapp/pages/discover/video.dart';
import 'package:journapp/pages/goal/addGoal.dart';
import 'package:journapp/pages/goal/myGoals.dart';
import 'package:journapp/pages/home/home.dart';
import 'package:journapp/pages/journal/journal.dart';
import 'package:journapp/pages/journal/journalArchivePage%20.dart';
import 'package:journapp/pages/journal/journallist.dart';
import 'package:journapp/pages/journal/promptjournal.dart';
import 'package:journapp/pages/login/login.dart';
import 'package:journapp/pages/community/community.dart';
import 'package:journapp/pages/myspace/mySpace.dart';
import 'package:journapp/pages/plan/myPlan.dart';
import 'package:journapp/pages/report/reportPage.dart';
import 'package:journapp/pages/signup/signup.dart';
import 'package:journapp/pages/splash/splashScreenn.dart';
import 'package:journapp/pages/profile/profile.dart';
import 'package:journapp/pages/visionBoard/visionBoard.dart';
import 'package:journapp/pages/visionBoard/addVisionBoard.dart';

// void addDynamicRoutes() {
//   for (var page in allRoutes) {
//     if (page.name != null && page.name!.startsWith('/')) {
//       GetPage newPage = GetPage(
//         name: page.name,
//         page: () => _getPageByRouteName(page.name!),
//       );
//       // Add newPage to the allRoutes list
//       allRoutes.add(newPage);
//     }
//   }
// }

final allRoutes = [
  GetPage(name: "/", page: () => const LoginPage()),
  GetPage(name: "/signup", page: () => const SignUpPage()),
  GetPage(name: "/home", page: () => const HomePage()),
  GetPage(name: "/journal", page: () => const FreeJournalPage()),
  GetPage(name: "/journalList", page: () => const JournalListPage()),
  GetPage(name: "/splash", page: () => const SplashScreen()),
  GetPage(name: "/addGoal", page: () => const AddGoalPage()),
  GetPage(name: "/community", page: () => const CommunityPage()),
  GetPage(name: "/discover", page: () => const DiscoverPage()),
  GetPage(name: "/myspace", page: () => const MySpacePage()),
  GetPage(name: "/promptJournal", page: () => const PromptJournalPage()),
  GetPage(name: "/profile", page: () => const ProfilePage()),
  GetPage(name: "/visionBoard", page: () => const VisionBoardPage()),
  GetPage(name: "/myGoals", page: () => const MyGoalsPage()),
  GetPage(name: "/myPlan", page: () => const MyPlanPage()),
  GetPage(name: "/addVisionBoard", page: () => const CreateVisionBoardPage()),
  GetPage(name: "/video", page: () => const VideoPage()),
  GetPage(name: "/journalArchive", page: () => const JournalArchivePage()),
  GetPage(name: "/report", page: () => const ReportsPage()),
  GetPage(name: "/aiAssistant", page: () => const AiAssistantPage()),
  // GetPage(
  //     name: "/visit",
  //     page: () => VisitPage(customers: [], activities: [])),
];
