import 'package:coopmt_app/ui/shared/global/colors.dart';
import 'package:flutter/material.dart';

// import 'package:coopmt_app/pages/auth.dart';
import 'package:coopmt_app/router/routes.dart';
import 'package:coopmt_app/ui/views/login_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'package:coopmt_app/helpers/dialogs.dart';

// void main() => runApp(const AppState());

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await dotenv.load(fileName: '.env');
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CoopApp();
  }
}

class CoopApp extends StatelessWidget {
  const CoopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      // theme: ThemeData(primaryColor: Colors.green, accentColor: Colors.orange),
      // theme: ThemeData.light(),
      theme: ThemeData(
        primaryColor: ColorStyles.primaryColor,
        primaryColorDark: ColorStyles.primaryColorDark,
        primaryColorLight: ColorStyles.primaryColorLight,
        dividerColor: ColorStyles.dividerColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: ColorStyles.secondaryColor,
            tertiary: ColorStyles.tertiaryColor,
            error: ColorStyles.dangerColor),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
              color: ColorStyles.headingColor,
              fontSize: 23.0,
              fontWeight: FontWeight.w700),
          headlineMedium: TextStyle(
              color: ColorStyles.headingColor,
              fontSize: 22.0,
              fontWeight: FontWeight.w700),
          headlineSmall: TextStyle(
              color: ColorStyles.headingColor,
              fontSize: 21.0,
              fontWeight: FontWeight.w700),
          titleLarge: TextStyle(
              color: ColorStyles.bodyColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w600),
          titleMedium: TextStyle(
              color: ColorStyles.bodyColor,
              fontSize: 19.0,
              fontWeight: FontWeight.w600),
          titleSmall: TextStyle(
              color: ColorStyles.bodyColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
            color: ColorStyles.bodyColor,
          ),
          bodyMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: ColorStyles.bodyColor,
          ),
          bodySmall: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            color: ColorStyles.bodyColor,
          ),
        ),
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      initialRoute: LoginView.id,
      // routes: {AuthPage.ROUTE: (_) => AuthPage()},
      routes: customRoutes,
    );
  }
}
