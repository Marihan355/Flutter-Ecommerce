import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'auth_check_page.dart';
import 'core/data/datasources/storage_local_data_source.dart';
import 'core/config/app_theme.dart';
import 'core/presentation/cubit/theme_cubit.dart';
import 'core/presentation/cubit/localization_cubit.dart';
import 'features/cart/data/models/cart_item.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/favorite/data/models/favorite_item.dart';
import 'features/favorite/presentation/cubit/favorite_cubit.dart';
import 'features/home/data/datasources/product_remote_data_source.dart';
import 'features/home/data/repositories/product_repository.dart';
import 'features/home/presentation/cubit/product_cubit.dart';
import 'core/data/datasources/api_service.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/repository/auth_repo.dart';
//import 'features/auth/screens/auth_check_page.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';

import 'features/home/presentation/pages/product_page_wrapper.dart';
import 'features/welcome/presentation/pages/welcome_page.dart';

class MyApp extends StatelessWidget {
final StorageLocalDataSource storage;

const MyApp({super.key, required this.storage}); //shared prefernces

//dependancy preparations
@override
Widget build(BuildContext context) {
final favBox = Hive.box<FavoriteItem>('favorites');
final cartBox = Hive.box<CartItem>('cart');
final api = ApiService();
final remote = ProductRemoteDataSource(api);
final productRepo = ProductRepository(remote);

return ScreenUtilInit(   //for ressponsiveness so the screen adapt to different phone screens
designSize: const Size(390, 844), //the screen size my ui is orginally for
minTextAdapt: true, //makes text scale properly on small/large screens
builder: (context, child) {
return MultiBlocProvider(  //state mangers for: //gives all cubits to the widget tree
  providers: [
  BlocProvider(create: (_) => LocalizationCubit(storage)..loadLocale()),  //translation
  BlocProvider(create: (_) => ThemeCubit(storage)..loadTheme()),   //theme
  BlocProvider(create: (_) => ProductCubit(productRepo)..fetchProducts()), //fetch and store product data
  BlocProvider(create: (_) => CartCubit(cartBox)), //manage tthe car
  BlocProvider(create: (_) => FavoritesCubit(favBox)), //manage favorite
  BlocProvider(create: (_) => AuthCubit(AuthRepo())),
  ],
child: BlocBuilder<ThemeCubit, ThemeMode>(  //ensures the whole app theme updates dynamically
builder: (context, themeMode) {
  return MaterialApp(
    debugShowCheckedModeBanner: false, //removes the debug banner
    title: 'Marihan Store',
    locale: context.locale, //current language
   supportedLocales: context.supportedLocales, 
    localizationsDelegates: context.localizationDelegates, ////allows translation
    theme: AppTheme.lightTheme(context.locale),
    darkTheme: AppTheme.darkTheme(context.locale),
    themeMode: themeMode,

    initialRoute: "/splash", //app starts on splash
    routes: {
      "/splash": (_) => const SplashScreen(),
      "/onboarding": (_) => const OnboardingScreen(),
      "/welcome": (_) => const WelcomeScreen(),

      "/auth-check": (_) => const AuthCheckPage(),
      "/login": (_) => LoginScreen(),
      "/register": (_) => RegisterScreen(),
      "/products": (_) => const ProductsPageWrapper(),
    },

   // home: const SplashScreen(),
  );
},
),
 );
},
);
  }
}