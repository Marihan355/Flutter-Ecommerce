import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/cubit/theme_cubit.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/bottom_nav_bar.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../../../auth/cubit/auth_state.dart';
import '../../presentation/cubit/category_cubit.dart';
import 'product_grid.dart';
import 'package:cached_network_image/cached_network_image.dart';


/// wrapped in ProductsPageWrapper that initializes Cubits and Repos.
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, List<String>>(
      builder: (context, categories) {
        // Show loader while categories are being fetched
        if (categories.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return DefaultTabController(
          length: categories.length,
          child: Scaffold(
            bottomNavigationBar: const BottomNavBar(currentIndex: 1,),
            appBar: AppBar(
              title: Text('products'.tr()),
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                labelStyle: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
                tabs: categories
                    .map((c) => Tab(child: CustomText(c.tr())))
                    .toList(),
              ),
              actions: [
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final bool isLoggedIn = state is AuthSuccess;

                    return IconButton(
                      icon: Icon(isLoggedIn ? Icons.logout : Icons.login),
                      color: Colors.white,
                      onPressed: () {
                        if (isLoggedIn) {
                          // LOGOUT
                          context.read<AuthCubit>().logout();
                          Navigator.pushReplacementNamed(context, "/login");
                        } else {
                          // NOT LOGGED IN: GO TO LOGIN SCREEN
                          Navigator.pushReplacementNamed(context, "/login");
                        }
                      },
                    );
                  },
                ),
                // Toggle between Arabic and English
                IconButton(
                  icon: const Icon(Icons.language),
                  color:Colors.white,
                  onPressed: () {
                    final newLocale = context.locale.languageCode == 'en'
                        ? const Locale('ar')
                        : const Locale('en');
                    context.setLocale(newLocale);
                  },
                ),

                // Toggle between light and dark mode
                IconButton(
                  icon: const Icon(Icons.brightness_6),
                  color:Colors.white,
                  onPressed: () =>
                      context.read<ThemeCubit>().toggleTheme(),
                ),
              ],
            ),
            body: Column(
              children: [
                // BANNER
                Container(
                  height: 180.h,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),

                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: CachedNetworkImage(
                          imageUrl:
                          "https://plus.unsplash.com/premium_photo-1670934158407-d2009128cb02?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          placeholder: (context, url) => Container(
                            color: Colors.grey.shade300,
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.error, color: Colors.blueGrey),
                          ),
                        ),
                      ),

                      // TEXT ON TOP
                      Text(
                        "White Friday Sale",
                        style: TextStyle(
                          fontFamily: "PlayfairDisplay",
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(2, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Tab content
                Expanded(
                  child: TabBarView(
                    children: categories
                        .map((c) => ProductGrid(category: c))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}