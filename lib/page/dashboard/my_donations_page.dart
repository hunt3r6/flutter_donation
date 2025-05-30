import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/donation/donation_cubit.dart';
import 'package:flutter_donation/core/util/currency_helper.dart';
import 'package:flutter_donation/core/widget/custom_app_bar.dart';
import 'package:flutter_donation/resource/model/donation_model.dart';
import 'package:go_router/go_router.dart';

class MyDonationsPage extends StatefulWidget {
  const MyDonationsPage({super.key});

  @override
  State<MyDonationsPage> createState() => _MyDonationsPageState();
}

class _MyDonationsPageState extends State<MyDonationsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getMyDonations();
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  void getMyDonations() {
    context.read<DonationCubit>().fetchDonations();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<DonationCubit>().fetchDonations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Riwayat Donasi Saya', centerTitle: false),
      body: BlocBuilder<DonationCubit, DonationState>(
        builder: (context, state) {
          if (state is DonationLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DonationError) {
            return Center(child: Text(state.message));
          } else if (state is DonationLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.donations.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.donations.length) {
                  return Center(child: CircularProgressIndicator());
                }
                final donations = state.donations[index];
                return _buildDonationCard(donations);
              },
            );
          }

          return Center(child: Text('No donations found'));
        },
      ),
    );
  }

  Widget _buildDonationCard(DonationModel donation) {
    Color getStatusColor(String? status) {
      switch (status?.toLowerCase()) {
        case 'expired':
          return Colors.red;
        case 'pending':
          return Colors.orange;
        case 'success':
          return Colors.green;
        default:
          return Colors.grey;
      }
    }

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${donation.campaign?.title}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(donation.status),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${donation.status}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  CurrencyHelper.formatRupiah(donation.amount?.toDouble() ?? 0),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${donation.createdAt}',
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ],
            ),
            if (donation.status?.toLowerCase() == 'pending')
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed:
                      () => context.push('/payment/${donation.snapToken}'),
                  child: Text('Bayar Sekarang'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
