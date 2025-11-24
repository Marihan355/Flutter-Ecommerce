import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'core/data/datasources/storage_local_data_source.dart';
import 'features/cart/data/models/cart_item.dart';
import 'features/favorite/data/models/favorite_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/repository/auth_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //flutter runs with a widget tree , make sure flutter is ready before i call all the async operationd

  await EasyLocalization.ensureInitialized(); //initialize Localization
  await Hive.initFlutter();   // initialize hive

  //register hive adapters
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(FavoriteItemAdapter());

  // open hive boxes
  await Hive.openBox<CartItem>('cart');
  await Hive.openBox<FavoriteItem>('favorites');

  // initialize local storage
  await StorageLocalDataSource.init();
  final storage = StorageLocalDataSource.instance;

//intialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthCubit(AuthRepo()),
          ),
        ],
        child: MyApp(storage: storage), //sharedpreferences
      ),
    ),
  );
}