// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
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
    '/dashboard/campaign_list',
    '/dashboard/my_donations',
    '/dashboard/account',
  ];

  int currentIndex = 0;

  List<NavigationDestination> get _appBarDestinations =>
      List.generate(tabs.length, (index) {
        final icons = [
          CupertinoIcons.house,
          CupertinoIcons.list_bullet,
          CupertinoIcons.gift,
          CupertinoIcons.person,
        ];

        final labels = ['Home', 'Campaigns', 'Donations', 'Account'];

        return NavigationDestination(
          selectedIcon: Icon(icons[index], color: Colors.blue),
          icon: Icon(icons[index]),
          label: labels[index],
        );
      });

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = GoRouterState.of(context).uri.toString();
    final index = tabs.indexWhere((tab) => location.startsWith(tab));
    setState(() {
      currentIndex = index == -1 ? 0 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      extendBody: true,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0, left: 14.0, right: 14.0),
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
