//notifications requirement
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'screens/categories_screen.dart';
import 'screens/login.dart';
import 'screens/profile.dart';
import 'screens/register.dart';
import 'services/notification_service.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  await NotificationService.init();


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );


  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    final body = notification?.body ??
        "Tap to open the app and see today's random recipe!";
    NotificationService.showRandomRecipeNotification(body);
  });



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const RegisterPage(),
        "/home": (context) => const CategoriesScreen(
          title: 'Recipe Categories',
        ),
        "/profile": (context) => const ProfilePage(),
        "/login": (context) => const LoginPage(),
      },
    );
  }
}
//----------------------------------------------------------
//AUTH IMPLEMENTED

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'services/notification_service.dart';
// import 'firebase_options.dart';
// import 'screens/categories_screen.dart';
// import 'screens/login.dart';
// import 'screens/profile.dart';
// import 'screens/register.dart';
// import 'firebase_options.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   await NotificationService.init();
//
//
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   runApp(const MyApp());
// }
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you want to do something when message received in background
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Meals App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
//       ),
//
//
//       initialRoute: "/",
//       routes: {
//         "/": (context) => const RegisterPage(),
//         "/home": (context) => const CategoriesScreen(
//           title: 'Recipe Categories',
//         ),
//         "/profile": (context) => const ProfilePage(),
//         "/login": (context) => const LoginPage(),
//       },
//     );
//   }
// }


//----------------------------------------------------------
//INITIAL LAB2


// import 'package:flutter/material.dart';
// import 'screens/categories_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'screens/profile.dart';
// import 'screens/register.dart';
//
//
//
// void main() async{
//   // runApp(const MyApp());
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Meals App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
//         useMaterial3: true,
//       ),
//       home: const CategoriesScreen(title: 'Recipe Categories'),
//     );
//   }
// }
//
