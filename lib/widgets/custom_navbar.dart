import 'package:flutter/material.dart';
import 'package:scannic/screens/cart_screen.dart';
import 'package:scannic/screens/home_screen.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  int selected = 0;
  bool heart = false;
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: StylishBottomBar(
        iconSpace: 1,
        option: DotBarOptions(dotStyle: DotStyle.tile),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            backgroundColor: Colors.red,
          ),
          BottomBarItem(
            icon: const Icon(Icons.book),
            title: const Text('Recents'),
            backgroundColor: Colors.orange,
          ),
          BottomBarItem(
            icon: const Icon(Icons.shopping_cart),
            title: const Text('My Cart'),
            backgroundColor: Colors.purple,
          ),
          BottomBarItem(
            icon: const Icon(Icons.account_circle),
            title: const Text('Account'),
            backgroundColor: Colors.green,
          ),
        ],

        hasNotch: true,
        notchStyle: NotchStyle.circle,
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
            controller.jumpToPage(index);
          });
        },
      ),

      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          Center(child: Text('Recents')),
          CartScreen(),
          Center(child: Text('User Account')),
        ],
      ),
    );
  }
}
