import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import '../../../../core/data/datasources/storage_local_data_source.dart';
import '../../../welcome/presentation/pages/welcome_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final storage = StorageLocalDataSource.instance;

    final pages = [
      _buildPage(
        image: "https://images.unsplash.com/photo-1758995116383-f51775896add?q=80&w=1470&auto=format&fit=crop",
        title: "Welcome to Marihan Store",
        body: "Discover elegant products and shop with ease from the comfort of your home.",
      ),
      _buildPage(
        image: "https://plus.unsplash.com/premium_photo-1734095825380-d3bd3f6e8b35?q=80&w=870&auto=format&fit=crop",
        title: "Fast Delivery",
        body: "Receive your orders quickly and safely at your doorstep.",
      ),
      _buildPage(
        image: "https://plus.unsplash.com/premium_photo-1708271598484-658dd9ca5e61?q=80&w=774&auto=format&fit=crop",
        title: "Get Started",
        body: "Sign in or explore freely before joining.",
      ),
    ];

    void goToWelcome() async {
      await storage.setOnboardingCompleted();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          /// Swipe pages
          LiquidSwipe(
            pages: pages,
            fullTransitionValue: 600,
            waveType: WaveType.liquidReveal,
            enableSideReveal: true,
            slideIconWidget: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPageChangeCallback: (page) => setState(() => currentPage = page),
          ),

          /// Bottom controls
          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// SKIP
                if (currentPage != pages.length - 1)
                  GestureDetector(
                    onTap: goToWelcome,
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 40),

                /// CENTER: Dots
                Row(
                  children: List.generate(
                    pages.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: currentPage == index ? 14.w : 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Colors.deepPurple
                            : Colors.deepPurple.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                /// GET STARTED
                if (currentPage == pages.length - 1)
                  GestureDetector(
                    onTap: goToWelcome,
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String body,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.network(
              image,
              height: 260.h,
              width: 320.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 30.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              fontFamily: "PlayfairDisplay",
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black87,
              height: 1.4,
              fontFamily: "PlayfairDisplay",
            ),
          ),
        ],
      ),
    );
  }
}