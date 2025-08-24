import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/constom_bottom_nav_bar.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/features/home_user/presentation/pages/bottom_nav_pages/create_waste_list.dart';
import 'package:trash2cash/features/home_user/presentation/pages/bottom_nav_pages/dashbord.dart';
import 'package:trash2cash/features/home_user/presentation/pages/bottom_nav_pages/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Dashbord(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Tcolor.PrimaryYellow,
        shape: CircleBorder(),
        child: const Icon(Icons.add, size: 32, color: Colors.green),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateWasteList()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onTabSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}