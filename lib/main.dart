import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journapp/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:journapp/providers/theme_provider.dart';
import 'package:journapp/pages/splash/splashScreenn.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
  // addDynamicRoutes();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialRoute: '/',
      title: 'JournApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 93, 153, 244),
        ),
        useMaterial3: true,
      ),
      // darkTheme: ThemeData.dark(), // Provide dark theme.
      themeMode: ThemeMode.system,
      // home: const Login(),
      getPages: allRoutes,
    );
  }
}
