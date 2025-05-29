import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/campaign/campaign_cubit.dart';
import 'package:flutter_donation/core/util/currency_helper.dart';
import 'package:flutter_donation/core/util/date_utils_helper.dart';
import 'package:flutter_donation/core/widget/action_button.dart';
import 'package:flutter_donation/core/widget/custom_app_bar.dart';
import 'package:flutter_donation/core/widget/fund_progress_bar.dart';
import 'package:flutter_donation/resource/model/campaign_model.dart';
import 'package:flutter_donation/resource/model/donation_model.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';

class DetailCampaignPage extends StatefulWidget {
  const DetailCampaignPage({super.key});

  @override
  State<DetailCampaignPage> createState() => _DetailCampaignPageState();
}

class _DetailCampaignPageState extends State<DetailCampaignPage> {
  bool _isButtonDisabled = false;
  String _slugCampaign = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detail Campaign',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<CampaignCubit, CampaignState>(
        listener: (context, state) {
          if (state is CampaignDetailLoaded) {
            final campaign = state.apiResponse.data;
            // Update the state for the button, triggering a rebuild of the button
            setState(() {
              _isButtonDisabled =
                  DateUtilsHelper.daysUntil(campaign.maxDate) == 0;
              _slugCampaign = campaign.slug ?? '';
            });
          }
        },
        builder: (context, state) {
          if (state is CampaignLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CampaignError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is CampaignDetailLoaded) {
            final campaign = state.apiResponse.data;
            final donations = state.apiResponse.donations; // Get donations here

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCampaignSummaryCard(campaign),
                  _buildCampaignerInfoCard(campaign),
                  _buildStoryCard(campaign),
                  _buildDonatorListCard(donations),
                ],
              ),
            );
          }
          return const Center(child: Text('No campaign details available'));
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ActionButton(
          label: _isButtonDisabled ? 'Donasi Ditutup' : 'Donasi Sekarang',
          onPressed:
              _isButtonDisabled
                  ? null
                  : () {
                    context.push('/donate/$_slugCampaign');
                  },
          colorButton: _isButtonDisabled ? Colors.grey : Colors.blue,
        ),
      ),
    );
  }

  /// Builds a common card container for content
  Widget _buildInfoCard({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(
              alpha: 0.2,
            ), // Use withOpacity for clarity
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildCampaignSummaryCard(CampaignModel campaign) {
    return _buildInfoCard(
      children: [
        CachedNetworkImage(
          height: 200,
          width: double.infinity,
          imageUrl: campaign.image ?? '',
          imageBuilder:
              (_, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          placeholder:
              (context, url) =>
                  const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8.0), // Consistent spacing
        Text(
          campaign.title ?? '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        Text(
          CurrencyHelper.formatRupiah(
            double.parse(campaign.sumDonation?[0].total ?? '0'),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Terkumpul dari ${CurrencyHelper.formatRupiah(campaign.targetDonation?.toDouble() ?? 0.0)}',
        ),
        const SizedBox(height: 8.0),
        FundProgressBar(
          collectedAmount: double.parse(campaign.sumDonation?[0].total ?? '0'),
          maxAmount: campaign.targetDonation?.toDouble() ?? 0.0,
        ),
        const SizedBox(height: 2.0),
      ],
    );
  }

  Widget _buildCampaignerInfoCard(CampaignModel campaign) {
    return _buildInfoCard(
      children: [
        const Text(
          'Penggalang Dana',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Divider(color: Colors.grey.withValues(alpha: 0.5)),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                campaign.user?.avatar ?? '', // Handle null avatar
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              campaign.user?.name ?? 'Anonim', // Handle null name
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStoryCard(CampaignModel campaign) {
    return _buildInfoCard(
      children: [
        const Text(
          'Cerita',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Divider(color: Colors.grey.withValues(alpha: 0.5)),
        HtmlWidget(campaign.description ?? ''),
      ],
    );
  }

  Widget _buildDonatorListCard(List<DonationModel> donations) {
    return _buildInfoCard(
      children: [
        const Text(
          'Donator',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Divider(color: Colors.grey.withValues(alpha: 0.5)),
        _buildDonatorList(donations),
      ],
    );
  }

  Widget _buildDonatorList(List<DonationModel> donations) {
    if (donations.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Center(child: Text('Belum ada donasi untuk kampanye ini.')),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Prevent inner scrolling
      itemCount: donations.length,
      itemBuilder: (context, index) {
        final donation = donations[index];
        return ListTile(
          leading: CircleAvatar(
            // backgroundImage: NetworkImage(donation.donatur?.avatar ?? ''),
          ),
          // title: Text(donation.donatur?.name ?? 'Anonim'), // Handle null name
          subtitle: Text(
            CurrencyHelper.formatRupiah(donation.amount?.toDouble() ?? 0.0),
          ),
        );
      },
    );
  }
}
