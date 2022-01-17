import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repose_application/src/pages/home_page.dart';
import 'package:repose_application/src/providers/main_provider.dart';
import 'package:repose_application/src/providers/sugerencias_provider.dart';
import 'package:repose_application/src/themes/theme_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return FutureBuilder<bool>(
        future: mainProvider.getPreferences(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ScreenUtilInit(
                designSize: ScreenUtil.defaultSize,
                builder: () => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Demo',
                    theme: AppTheme.themeData(mainProvider.mode),
                    home: const HomePage()));
          }
          return const SizedBox.square(
              dimension: 25.0, child: CircularProgressIndicator());
        });
  }
}