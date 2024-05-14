import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:scanner_app/view/network_screen.dart';
import 'package:scanner_app/view/qr_generator.dart';
import 'package:scanner_app/view/scanner_screen.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(2); // Initialize to index of GenerateQr screen

class BottomNavScreen extends StatefulWidget {

  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    // Initialize screens list here, after widget is available
    screens = [
      const GenerateQr(),
      ScannerScreen(),
      const NetWorkingScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, int newIndex, _) {
        return Scaffold(
          backgroundColor: const Color(0xFF202020),
          body: screens.isNotEmpty ? screens[newIndex] : const SizedBox(), // Check if screens list is not empty
          bottomNavigationBar: CircleNavBar(
            elevation: 10,
            onTap: (index) {
              indexChangeNotifier.value = index;
            },
            circleColor: Colors.deepPurple,
            circleShadowColor: Colors.white,
            activeIndex: indexChangeNotifier.value,
            activeIcons: const [
              Icon(Icons.explore, color: Colors.white, size: 35),
              Icon(Icons.qr_code, color: Colors.white, size: 35),
              Icon(Icons.lan_outlined, color: Colors.white, size: 35)
            ],
            inactiveIcons: const [
              Icon(Icons.explore, color: Colors.white, size: 35),
              Icon(Icons.qr_code, color: Colors.white, size: 35),
              Icon(Icons.lan_outlined, color: Colors.white, size: 35)
            ],
            height: 80,
            circleWidth: 70,
            gradient: const LinearGradient(
                colors: [Colors.black, Colors.black54],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
            color: Colors.black,
            shadowColor: Colors.white,
            circleGradient: const LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.deepPurpleAccent]),
          ),
        );
      },
    );
  }
}
