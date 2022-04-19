import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:protein_log/model/firebase_auth.dart';
import 'package:protein_log/pages/calendar_page.dart';
import 'package:protein_log/pages/sign_in_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuthentication(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthentication>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // darkTheme: ThemeData.dark(),
        home: AuthenticationWrapper(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ja'),
        ],
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<User?>(
    //   stream: FirebaseAuth.instance.authStateChanges(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //     if (snapshot.hasData) {
    //       return Builder(builder: (context) {
    //         return CalendarPage();
    //       });
    //     }
    //     return SignInPage();
    //   },
    // );
    final firebaseUser = context.watch<User?>();
    print('firebaseUser: $firebaseUser');
    if (firebaseUser != null) {
      return Builder(builder: (context) {
        return CalendarPage();
      });
    }
    return SignInPage();
  }
}
