import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lonelydubai/Screens/DestinationsScreen.dart';
import 'package:lonelydubai/Screens/HomeScreen.dart';
import 'package:lonelydubai/Screens/ToursScreen.dart';
import 'package:lonelydubai/Themes/AppTheme.dart';
import 'package:lonelydubai/Widgets/DotIndicator.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({Key? key}) : super(key: key);

  @override
  _MainTabScreenState createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [HomeScreen(), DestinationsScreen(), ToursScreen()],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(5.0),
        child: TabBar(
          indicator: const DotIndicator(),
          controller: _tabController,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          tabs: [
            tabItem(
                SvgPicture.asset(
                  "assets/icons/icon_home.svg",
                  height: 20,
                  color: Colors.grey,
                ),
                "Home",
                0),
            tabItem(
                SvgPicture.asset(
                  "assets/icons/icon_tours.svg",
                  height: 20,
                  color: Colors.grey,
                ),
                "Destinations",
                1),
            tabItem(
                SvgPicture.asset(
                  "assets/icons/icon_destination.svg",
                  height: 25,
                  color: Colors.grey,
                ),
                "Tours",
                2),
          ],
          labelColor: AppTheme.pink,
          unselectedLabelColor: Colors.grey,
        ),
      ),
    );
  }

  Widget tabItem(SvgPicture icon, String text, int itemIndex) {
    if (selectedIndex == itemIndex) {
      return Tab(text: text);
    } else {
      return Tab(icon: icon);
    }
  }
}
