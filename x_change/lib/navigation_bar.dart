import 'package:x_change/currency_exchange_screen.dart';
import 'package:x_change/dashboard.dart';
import 'package:x_change/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class BottomNavBar extends StatefulWidget {
  final String token;
  const BottomNavBar({super.key, required this.token});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // List of screens to display for each tab
    final List<Widget> _screens = [
      DashBoardPage(token: widget.token), // Access token using widget.token
      CurrencyExchangeScreen(token: widget.token,),
      ProfilePage(
        token: widget.token,
      ),
    ];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.payments, size: 30),
          Icon(Icons.person_2_rounded, size: 30),
        ],
        color: const Color.fromARGB(255, 91, 141, 151),
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 550),
        onTap: (index) {
          setState(() {
            _page = index; // Update the selected page index
          });
        },
        letIndexChange: (index) => true,
      ),
      body: _screens[_page], // Display the corresponding screen
    );
  }
}

// Sample Screen 2: PaymentsScreen
class PaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Text(
          'Payments Screen',
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
      ),
    );
  }
}
