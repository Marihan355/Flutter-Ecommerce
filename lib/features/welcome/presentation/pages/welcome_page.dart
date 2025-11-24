import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/custom_text.dart';
import '../../../home/presentation/pages/product_page_wrapper.dart';

class WelcomeScreen extends StatelessWidget {
const WelcomeScreen({super.key});

@override
Widget build(BuildContext context) {
return SafeArea(
 child: Scaffold(
  backgroundColor: Colors.white,
  body: Padding(
 padding: EdgeInsets.symmetric(horizontal: 20.w),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
 children: [
  const CircleAvatar(
   radius: 80,
   backgroundImage: AssetImage('assets/images/e4.jpeg'),
   ),
   SizedBox(height: 40.h),

 const CustomText('Welcome to Marihan Store',
 style: TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.deepPurple,
  fontFamily: "PlayfairDisplay",
   ),
 ),
  SizedBox(height: 16.h),

  const CustomText(
    'Your elegant shopping experience awaits.',
   style: TextStyle(
    fontSize: 14,
    color: Colors.black, fontFamily: "PlayfairDisplay",
    ),
  ),
 SizedBox(height: 60.h),

//sign in
ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, "/login");
    },
 style: ElevatedButton.styleFrom(
  backgroundColor: Colors.deepPurple,
  minimumSize: Size(double.infinity, 50.h),
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12.r),
    ),
  ),
  child: const Text(
    "Sign In",
    style: TextStyle(color: Colors.white),
  ),
  ),
  SizedBox(height: 16.h),

// sign up
OutlinedButton(
    onPressed: () {
      Navigator.pushNamed(context, "/register");
    },
  style: OutlinedButton.styleFrom(
    side: const BorderSide(color: Colors.deepPurple),
    minimumSize: Size(double.infinity,50.h),
   shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.r),
    ),
    ),
  child: const Text(
    "Sign Up",
    style: TextStyle(color: Colors.deepPurple),
  ),
  ),
  SizedBox(height: 16.h),

//skip to home
TextButton(
  onPressed: () {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const ProductsPageWrapper()),
    );
  },
  child: const Text(
    "Skip for now",
    style: TextStyle(color: Colors.deepPurple),
    ),
  ),
  ],
 ),
 ),
  ),
 );
}
}