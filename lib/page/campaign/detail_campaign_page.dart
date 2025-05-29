import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/campaign/campaign_cubit.dart';
import 'package:flutter_donation/core/util/currency_helper.dart';
import 'package:flutter_donation/core/widget/action_button.dart';
import 'package:flutter_donation/core/widget/custom_app_bar.dart';
import 'package:flutter_donation/core/widget/fund_progress_bar.dart';
import 'package:flutter_donation/resource/model/donation_model.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';

class DetailCampaignPage extends StatefulWidget {
  const DetailCampaignPage({super.key});

  @override
  State<DetailCampaignPage> createState() => _DetailCampaignPageState();
}

class _DetailCampaignPageState extends State<DetailCampaignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detail Campaign',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(context),
        ),
      ),
      body: BlocBuilder<CampaignCubit, CampaignState>(
        builder: (context, state) {
          if (state is CampaignLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CampaignError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is CampaignDetailLoaded) {
            final apiResponse = state.apiResponse;
            final campaign = apiResponse.data;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                            0,
                            3,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.0,
                      children: [
                        CachedNetworkImage(
                          height: 200,
                          width: double.infinity,
                          imageUrl: campaign.image,
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
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                        Text(
                          campaign.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          CurrencyHelper.formatRupiah(
                            double.parse(campaign.sumDonation[0].total),
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          'Terkumpul dari ${CurrencyHelper.formatRupiah(campaign.targetDonation.toDouble())}',
                        ),
                        FundProgressBar(
                          collectedAmount: double.parse(
                            campaign.sumDonation[0].total,
                          ),
                          maxAmount: campaign.targetDonation.toDouble(),
                        ),
                        const SizedBox(height: 2.0),
                      ],
                    ),
                  ),

                  // Display the camapaign details
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.0,
                      children: [
                        const Text(
                          'Penggalang Dana',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(color: Colors.grey.withValues(alpha: 0.5)),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                '${campaign.user.avatar}',
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '${campaign.user.name}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                            0,
                            3,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cerita',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(color: Colors.grey.withValues(alpha: 0.5)),
                        HtmlWidget(campaign.description),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                            0,
                            3,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Donator',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(color: Colors.grey.withValues(alpha: 0.5)),
                        _buildDonatorList(apiResponse.donations),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No campaign details available'));
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ActionButton(label: 'Donasi Sekarang', onPressed: () {}),
      ),
    );
  }

  Widget _buildDonatorList(List<DonationModel> donations) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: donations.length,
      itemBuilder: (context, index) {
        final donation = donations[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(donation.donatur?.avatar ?? ''),
          ),
          title: Text(donation.donatur?.name ?? ''),
          subtitle: Text(
            CurrencyHelper.formatRupiah(donation.amount?.toDouble() ?? 0.0),
          ),
        );
      },
    );
  }
}
