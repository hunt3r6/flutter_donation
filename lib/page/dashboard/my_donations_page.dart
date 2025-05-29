import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/donation/donation_cubit.dart';
import 'package:flutter_donation/core/util/currency_helper.dart';
import 'package:flutter_donation/core/widget/custom_app_bar.dart';
import 'package:flutter_donation/resource/model/donation_model.dart';

class MyDonationsPage extends StatefulWidget {
  const MyDonationsPage({super.key});

  @override
  State<MyDonationsPage> createState() => _MyDonationsPageState();
}

class _MyDonationsPageState extends State<MyDonationsPage> {
  @override
  void initState() {
    getMyDonations();
    super.initState();
  }

  void getMyDonations() {
    context.read<DonationCubit>().fetchDonations();
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
              itemCount: state.donations.length,
              itemBuilder: (context, index) {
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: donation.campaign?.image ?? '',
                  placeholder:
                      (context, url) =>
                          Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                spacing: 8.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${donation.campaign?.title}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${donation.createdAt}',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  Text(
                    CurrencyHelper.formatRupiah(
                      donation.amount?.toDouble() ?? 0,
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${donation.status}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
