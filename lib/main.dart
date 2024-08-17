import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tayar_admin_panel/core/constants.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/features/login/Ui/login_screen.dart';

String? token = "";
void main() async {
  setupLocator();
  await Hive.initFlutter();
  await Hive.openBox(kTokenBoxString);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
           iconTheme: IconThemeData(color: Colors.white),
           centerTitle: true,
           backgroundColor: AppColors.prussianBlue
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: kTokenBox.get(kTokenBoxString) == null
          ? const LoginScreen()
          : const HomeScreen(),
    );
  }
}
