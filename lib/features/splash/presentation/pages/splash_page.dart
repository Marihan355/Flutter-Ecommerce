import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../onboarding/presentation/pages/onboarding_page.dart';
import '../../../welcome/presentation/pages/welcome_page.dart';
import '../../../../core/data/datasources/storage_local_data_source.dart';

class SplashScreen extends StatefulWidget {
const SplashScreen({super.key});

@override
State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
  void initState() {
  super.initState();
  _navigateNext();
}

void _navigateNext() async {
 await Future.delayed(const Duration(seconds: 3));

final storage = StorageLocalDataSource.instance;

if (storage.onboardingCompleted) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const WelcomeScreen()),
  );
  } else {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const OnboardingScreen()),
  );
    }
  }

@override
Widget build(BuildContext context) {
return SafeArea(
  child: Scaffold(
  backgroundColor: Colors.white,
  body: Center(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  const CircleAvatar(
    radius: 80,
    backgroundImage: AssetImage('assets/images/e4.jpeg'),
  ),
  SizedBox(height: 30.h),
//text
 Text("Marihan Store",
  style: TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.deepPurple,
    fontFamily: "PlayfairDisplay",
    ),
  ),
  SizedBox(height: 10.h),
//text
 Text("Shopping experience with style",
   textAlign: TextAlign.center,
   style: TextStyle(
    fontSize: 14.sp,
    color: Colors.deepPurple,
    fontFamily: "PlayfairDisplay",
  ),
  ),
 ],
  ),
    ),
  ),
);
  }
}