import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/core/internet_services/dio_client.dart';
import 'package:junior_flutter/features/crud/presentation/components/birthday_management.dart';
import 'package:junior_flutter/features/crud/presentation/screens/admin_dashboard.dart';
import 'package:junior_flutter/features/crud/presentation/screens/basicInterviewScreen.dart';
import 'package:junior_flutter/features/crud/presentation/screens/editProfileScreen.dart';
// import 'package:junior_flutter/features/crud/presentation/screens/interview_management.dart';
import 'package:junior_flutter/features/crud/presentation/screens/invitationScreen.dart';
import 'package:junior_flutter/features/crud/presentation/screens/landing_screen.dart';
// import 'package:junior_flutter/features/crud/presentation/screens/management_section.dart';
import 'package:junior_flutter/features/crud/presentation/screens/profileScreen.dart';
import 'package:junior_flutter/features/crud/presentation/screens/specialInterviewScreen.dart';
import 'package:junior_flutter/features/crud/presentation/screens/wishListScreen.dart';
import 'package:junior_flutter/features/crud/presentation/screens/signupScreen.dart';
import 'package:junior_flutter/features/crud/presentation/screens/loginScreen.dart';
import 'features/crud/presentation/screens/get_started.dart';
import 'widgets/base_scaffold.dart';

void main() {
  DioClient.instance.initialize(); // Initialize DioClient
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Junior Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/get_started', // Set GetStartedScreen as initial route
      routes: {
        // Get Started Screen
        '/get_started': (context) => GetStartedScreen(
          onNavigate: (route) {
            Navigator.pushNamed(context, route);
          },
        ),
        // Pages without drawer or footer
        '/edit-profile':(context)=>  EditProfileScreen(),
        '/user-signup': (context) => const SignupScreen(),
        '/user-login': (context) => const LoginScreen(),
        '/edit-profile': (context) => EditProfileScreen(),
        // Pages with drawer and bottom nav bar
        '/AdminDashboardScreen': (context) => const BaseScaffold(
          title: 'Admin Dashboard',
          body: AdminDashboardScreen(),
          currentIndex: 0,
        ),
        '/birthday': (context) => const BaseScaffold(
          title: 'Birthday',
          body: InvitationScreen(),
          currentIndex: 1,
        ),
        '/basic-interview': (context) => const BaseScaffold(
          title: 'Basic Interview',
          body: BasicInterviewScreen(),
          currentIndex: 2,
        ),
        '/profile': (context) => const BaseScaffold(
          title: 'Profile',
          body: ProfileScreen(),
          currentIndex: 3,
        ),
        '/wishList': (context) => const BaseScaffold(
          title: 'Wish List',
          body: WishListScreen(),
          currentIndex: 0,
        ),
        '/home': (context) => const BaseScaffold(
          title: 'Home Page',
          body: LandingScreen(),
          currentIndex: 0,
        ),
        // '/interviewManagment': (context) => const BaseScaffold(
        //   title: 'Interview Management',
        //   body: InterviewManagementScreen(),
        //   currentIndex: 2,
        // ),
        '/invitation': (context) => const BaseScaffold(
          title: 'Invitation',
          body: InvitationScreen(),
          currentIndex: 1,
        ),
        '/specialInterview': (context) => const BaseScaffold(
          title: 'Special Interview',
          body: SpecialInterviewScreen(),
          currentIndex: 2,
        ),
      },
    );
  }
}

//routes