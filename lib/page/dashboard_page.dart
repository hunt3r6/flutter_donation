// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  final Widget child;
  const DashboardPage({super.key, required this.child});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final tabs = [
    '/dashboard/home',
    '/dashboard/donation_list',
    '/dashboard/my_donations',
    '/dashboard/account',
  ];

  int currentIndex = 0;

  final List<NavigationDestination> _appBarDestinations = const [
    NavigationDestination(
      selectedIcon: Icon(Icons.home_outlined, color: Colors.blue),
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.list_outlined, color: Colors.blue),
      icon: Icon(Icons.list_outlined),
      label: 'Donation List',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.volunteer_activism_outlined, color: Colors.blue),
      icon: Icon(Icons.volunteer_activism_outlined),
      label: 'My Donations',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.person_2_outlined, color: Colors.blue),
      icon: Icon(Icons.person_2_outlined),
      label: 'Account',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20.0,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: NavigationBar(
          surfaceTintColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: currentIndex,
          indicatorColor: Colors.white,
          backgroundColor: Colors.white,
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
            Set<WidgetState> states,
          ) {
            // Ketika dipilih, warna biru
            if (states.contains(WidgetState.selected)) {
              return TextStyle(color: Colors.blue);
            }
            // Ketika tidak dipilih, warna abu-abu
            return TextStyle(color: Colors.grey);
          }),
          onDestinationSelected: (index) {
            setState(() => currentIndex = index);
            context.go(tabs[index]);
          },
          destinations: _appBarDestinations,
        ),
      ),
    );
  }
}
