import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/providers/user_provider.dart';
import 'package:twitter_clone/theme/theme.dart';

import 'package:firebase_core/firebase_core.dart';

import 'features/home/view/home_view.dart';

// import 'features/auth/view/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyB9_NK29Tmjb4_7SZq1ienW9P7t8rWf7Z4',
      appId: '1:347116117901:web:8c85eeade4950ef2ae27c4',
      messagingSenderId: '347116117901',
      projectId: 'twitter-clone-22a05',
      storageBucket: 'twitter-clone-22a05.appspot.com',
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter layout demo',
        theme: AppTheme.theme,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              } else {
                if (snapshot.hasData) {
                  return const HomeView();
                } else {
                  return const LoginView();
                }
              }
            }),
      ),
    );
  }
}
