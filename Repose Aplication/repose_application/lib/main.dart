import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:repose_application/src/pages/login_page.dart';
import 'package:repose_application/src/pages/settings_page.dart';
import 'package:repose_application/src/pages/sing_up_page.dart';
import 'package:repose_application/src/providers/main_provider.dart';
import 'package:repose_application/src/providers/sugerencias_provider.dart';

import 'package:repose_application/src/themes/theme_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';
import 'dart:developer' as developer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => SugerenciaProvider())
        
      ],
      child:  const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _getTokenFCM();
  }

  @override
  Widget build(BuildContext context) {
     final mainProvider = Provider.of<MainProvider>(context);
    
    return FutureBuilder<bool>(
        future: mainProvider.getPreferences(),
        builder: (context, snapshot) {
          CollectionReference cliente = FirebaseFirestore.instance.collection('cliente');
          if (snapshot.hasData) {
           try {
              return ScreenUtilInit(
                designSize: const Size(360, 690),
                builder: () => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Demo',
                    theme: AppTheme.themeData(mainProvider.mode),
                    routes: {
                      "/singUp": (context) =>  const SignUpPage(),
                      "/settings": (context) =>  SettingPage(currentCliente: cliente,)
                    },
                    home: 
                    
                    mainProvider.token == ""
                        ? const LoginPage()
                        : JwtDecoder.isExpired(mainProvider.token)
                            ? const LoginPage()
                            : const LoginPage()));
           } catch (e) {
             //print(e);
           }
           
          }
          return const SizedBox.square(
              dimension: 100.0, child: CircularProgressIndicator());
        });
  }
  _getTokenFCM() async {
    String? token = await FirebaseMessaging.instance.getToken();
    developer.log(token!);
  }
}