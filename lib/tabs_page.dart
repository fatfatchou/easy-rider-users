import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:users/core/theme.dart';
import 'package:users/features/profile/presentation/pages/profile_page.dart';
import 'package:users/features/home/presentation/pages/home_page.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsPage> {
  final PageController _pageController = PageController();
  int _selectedPageIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectPage(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    var activePageTitle = ['', 'Profile'][_selectedPageIndex];

    return Scaffold(
      appBar: activePageTitle != ''
          ? AppBar(
              toolbarHeight: 120,
              backgroundColor: darkTheme ? Colors.black : Colors.white,
              surfaceTintColor: darkTheme ? Colors.black : Colors.white,
              title: Text(
                activePageTitle,
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.contentPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: true,
            )
          : null,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        children: const [
          HomePage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.contentSecondary,
        ),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        useLegacyColorScheme: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
            ),
            label: 'Home',
            activeIcon: SvgPicture.asset('assets/icons/home_selected.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/profile.svg'),
            label: 'Profile',
            activeIcon: SvgPicture.asset('assets/icons/profile_selected.svg'),
          ),
        ],
      ),
    );
  }
}
