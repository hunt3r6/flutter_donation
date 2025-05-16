import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/auth/auth_bloc.dart';
import 'package:flutter_donation/bloc/category/category_cubit.dart';
import 'package:flutter_donation/bloc/slider/sliders_cubit.dart';
import 'package:flutter_donation/core/widget/fund_progress_bar.dart';
import 'package:flutter_donation/core/widget/search_text_field.dart';
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

  @override
  void initState() {
    context.read<SlidersCubit>().getSliders();
    context.read<CategoryCubit>().getCategories();
    super.initState();
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
                        CircleAvatar(radius: 30),
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
                        IconButton(
                          onPressed: () {
                            if (isLoggedIn) {
                              context.read<AuthBloc>().add(
                                AuthEvent.logoutRequested(),
                              );
                              context.push('/login');
                            } else {
                              context.push('/login');
                            }
                          },
                          icon: Icon(
                            isLoggedIn
                                ? Icons.logout_rounded
                                : Icons.login_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SearchTextField(
                    controller: searchController,
                    hintText: 'Cari yang ingin kamu bantu',
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        context.push('/search?query=$value').then((value) {
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 45,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length + 1,
                        itemBuilder: (contex, index) {
                          if (index == 0) {
                            return _buildCategoryButton('Semua');
                          }
                          return _buildCategoryButton(
                            categories[index - 1].name ?? '',
                          );
                        },
                      ),
                    ),
                  );
                }
                return Center(child: Text('No Categories Available'));
              },
            ),
            SizedBox(height: 16.0),
            _buildDonationCard(),
            _buildDonationCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0.2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl:
                    'https://donasi.appdev.my.id/storage/campaigns/d07qNDLrVfHmHeip1jNfaX0T1UntkX59NHHpAUpQ.jpg',
                placeholder:
                    (context, url) =>
                        Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Sedekah Al-Qur'an Rp40.000 = SAKSI Amal Jariyahmu",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Rp. 8.736.302.761 Terkumpul dari Rp. 700.000.000'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FundProgressBar(collectedAmount: 50000, maxAmount: 100000),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _textIcon(CupertinoIcons.person_2, '200 Donatur'),
                _textIcon(CupertinoIcons.time, '164 Hari Lagi'),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _textIcon(IconData icon, String text) {
    return Row(spacing: 8, children: [Icon(icon), Text(text)]);
  }

  Widget _buildCategoryButton(String label) {
    final isSelected = selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          setState(() {
            selectedCategory = label;
          });
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

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
