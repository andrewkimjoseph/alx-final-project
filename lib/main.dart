import 'package:flutter/material.dart';
import 'package:saapp/switchboard/continue_test.dart';
import 'switchboard/continue.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  // ONBOARDING SCREEN
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  // BEFORE APP LAUNCHES, CONNECTION TO THE FIREBASE DATABASE IS FIRST ESTABLISHED
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const CrediTouch());
}

class BuildMaterialColorGenerator {
  static MaterialColor buildMaterialColorGenerator(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

class CrediTouch extends StatelessWidget {
  const CrediTouch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrediTouch',
      theme: ThemeData(
        // useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch:
                    BuildMaterialColorGenerator.buildMaterialColorGenerator(
                        const Color(0xFF2b334b)))
            .copyWith(background: Colors.white),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Continue(
              title: 'Version 1.0',
            ),
        '/test': (context) => const ContinueTest(
              title: 'Version 1.0 [TEST MODE]',
            )
      },
    );
  }
}
