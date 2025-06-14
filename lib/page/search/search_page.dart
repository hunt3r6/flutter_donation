import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/campaign/campaign_cubit.dart';
import 'package:flutter_donation/core/util/currency_helper.dart';
import 'package:flutter_donation/core/widget/custom_app_bar.dart';
import 'package:flutter_donation/core/widget/fund_progress_bar.dart';
import 'package:flutter_donation/resource/model/campaign_model.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: '',
      ),
      body: BlocBuilder<CampaignCubit, CampaignState>(
        builder: (context, state) {
          if (state is CampaignLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CampaignError) {
            return Center(child: Text(state.message));
          } else if (state is CampaignLoaded) {
            final campaigns = state.campaigns;
            if (campaigns.isEmpty) {
              return Center(child: Text('Campaign Tidak Ditemukan'));
            }
            return ListView.builder(
              itemCount: campaigns.length,
              itemBuilder: (context, index) {
                final campaign = campaigns[index];
                return _buildCardCampaign(campaign);
              },
            );
          }
          return Center(child: Text('Search Page'));
        },
      ),
    );
  }

  Widget _buildCardCampaign(CampaignModel campaign) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0.2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => context.push('/detail_campaign/${campaign.slug}'),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                width: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: CachedNetworkImage(
                    imageUrl: campaign.image ?? '',
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
                padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      campaign.title ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FundProgressBar(
                      collectedAmount: double.parse(
                        campaign.sumDonation?[0].total ?? '0',
                      ),
                      maxAmount: campaign.targetDonation?.toDouble() ?? 0.0,
                    ),
                    Text(
                      CurrencyHelper.formatRupiah(
                        double.parse(campaign.sumDonation?[0].total ?? '0'),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
