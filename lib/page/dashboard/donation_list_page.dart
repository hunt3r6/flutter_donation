import 'package:flutter/material.dart';

class DonationListPage extends StatefulWidget {
  const DonationListPage({super.key});

  @override
  State<DonationListPage> createState() => _DonationListPageState();
}

class _DonationListPageState extends State<DonationListPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Donation List Page"));
  }
}
