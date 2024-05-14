import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/model/company_model.dart';
import 'package:scanner_app/view/bottomnav_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NetworkProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BottomNavScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
