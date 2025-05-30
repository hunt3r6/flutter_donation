import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/auth/auth_bloc.dart';
import 'package:flutter_donation/bloc/campaign/campaign_cubit.dart';
import 'package:flutter_donation/bloc/category/category_cubit.dart';
import 'package:flutter_donation/bloc/slider/sliders_cubit.dart';
import 'package:flutter_donation/core/util/currency_helper.dart';
import 'package:flutter_donation/core/util/date_utils_helper.dart';
import 'package:flutter_donation/core/widget/fund_progress_bar.dart';
import 'package:flutter_donation/core/widget/search_text_field.dart';
import 'package:flutter_donation/resource/local/user_local_resource.dart';
import 'package:flutter_donation/resource/model/campaign_model.dart';
import 'package:flutter_donation/resource/model/category_model.dart';
import 'package:flutter_donation/resource/model/slider_model.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategory;
  TextEditingController searchController = TextEditingController();
  String? image = "";

  @override
  void initState() {
    selectedCategory = 'Semua';
    context.read<SlidersCubit>().getSliders();
    context.read<CategoryCubit>().getCategories();
    _filterByCategory('Semua');
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    final user = await UserLocalResource.getUser();
    setState(() {
      image = user?.avatar;
    });
  }

  void _filterByCategory(String slug) {
    // contoh: kalau 'Semua', ambil semua campaign
    if (slug == 'Semua') {
      context.read<CampaignCubit>().getCampaigns();
    } else {
      context.read<CampaignCubit>().getCampaignsByCategory(slugCategory: slug);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthBloc>().state is Authenticated;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.lightBlue.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 12,
                      children: [
                        isLoggedIn
                            ? CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(image ?? ''),
                            )
                            : const SizedBox.shrink(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Selamat Datang Orang Baik',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text('Ada hal baik yang bisa dilakukan'),
                            ],
                          ),
                        ),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is Unauthenticated) {
                              context.push('/login');
                            }
                          },
                          builder: (context, state) {
                            return IconButton(
                              onPressed: () {
                                if (isLoggedIn) {
                                  context.read<AuthBloc>().add(
                                    AuthEvent.logoutRequested(),
                                  );
                                } else {
                                  context.push('/login');
                                }
                              },
                              icon: Icon(
                                isLoggedIn
                                    ? Icons.logout_rounded
                                    : Icons.login_rounded,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SearchTextField(
                    controller: searchController,
                    hintText: 'Cari yang ingin kamu bantu',
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        context.push('/search/$value').then((value) {
                          searchController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<SlidersCubit, SlidersState>(
              builder: (context, state) {
                if (state is SliderLoading) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is SliderError) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: Text('Error: ${state.message}')),
                  );
                } else if (state is SliderLoaded) {
                  return _buildCarousel(state.sliders);
                }
                return Center(child: Text('No Sliders Available'));
              },
            ),

            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is CategoryError) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: Text('Error: ${state.message}')),
                  );
                } else if (state is CategoryLoaded) {
                  List<CategoryModel> categories = state.categories;
                  return SizedBox(
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length + 1,
                      itemBuilder: (contex, index) {
                        if (index == 0) {
                          return _buildCategoryButton('Semua', 'Semua');
                        }
                        return _buildCategoryButton(
                          categories[index - 1].name ?? '',
                          categories[index - 1].slug,
                        );
                      },
                    ),
                  );
                }
                return Center(child: Text('No Categories Available'));
              },
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<CampaignCubit, CampaignState>(
              builder: (context, state) {
                if (state is CampaignLoading) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is CampaignError) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: Text('Error: ${state.message}')),
                  );
                } else if (state is CampaignLoaded) {
                  List<CampaignModel> campaigns = state.campaigns;
                  if (campaigns.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text('Tidak Ada Kampanye yang Tersedia'),
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: campaigns.length,
                    itemBuilder: (context, index) {
                      return _buildDonationCard(campaigns[index]);
                    },
                  );
                }
                return Center(child: Text('No Campaigns Available'));
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Membuat Card untuk menampilkan informasi donasi
  Widget _buildDonationCard(CampaignModel campaign) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0.2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: () {
          context.push('/detail_campaign/${campaign.slug}');
        },
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                height: 180,
                width: double.infinity,
                imageUrl: campaign.image ?? '',
                placeholder:
                    (context, url) =>
                        Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                campaign.title ?? '',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                CurrencyHelper.formatRupiah(
                  double.parse(campaign.sumDonation?[0].total ?? '0'),
                ),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Terkumpul dari ${CurrencyHelper.formatRupiah(campaign.targetDonation?.toDouble() ?? 0.0)}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FundProgressBar(
                collectedAmount: double.parse(
                  campaign.sumDonation?[0].total ?? '',
                ),
                maxAmount: campaign.targetDonation?.toDouble() ?? 0.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _textIcon(CupertinoIcons.person, campaign.user?.name ?? ''),
                  _textIcon(
                    CupertinoIcons.time,
                    '${DateUtilsHelper.daysUntil(campaign.maxDate ?? DateTime.now())} Hari Lagi',
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// Membuat Widget Text dan Icon
  Widget _textIcon(IconData icon, String text) {
    return Row(spacing: 8, children: [Icon(icon), Text(text)]);
  }

  /// Membuat Tombol Kategori
  Widget _buildCategoryButton(String label, String? slug) {
    final isSelected = selectedCategory == slug;
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedCategory = slug;
            _filterByCategory(slug!);
          });
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }

  /// Membuat Carousel Slider
  Widget _buildCarousel(List<SliderModel> sliders) {
    final List<Widget> imageSliders =
        sliders
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image.network(item.image ?? '', fit: BoxFit.cover),
                  ),
                ),
              ),
            )
            .toList();

    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(enlargeCenterPage: true, autoPlay: true),
        ),
      ],
    );
  }
}
