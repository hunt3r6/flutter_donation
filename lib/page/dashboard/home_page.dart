import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_donation/core/widget/fund_progress_bar.dart';
import 'package:flutter_donation/core/widget/search_text_field.dart';
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
  Widget build(BuildContext context) {
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
                            context.push('/login');
                          },
                          icon: Icon(Icons.login_rounded),
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
            _buildCarousel(),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton('All'),
                  _buildCategoryButton('Masjid'),
                  _buildCategoryButton('Pendidikan'),
                  _buildCategoryButton('Kesehatan'),
                  _buildCategoryButton('Bencana'),
                  _buildCategoryButton('Yatim'),
                ],
              ),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
      padding: const EdgeInsets.only(right: 12.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          setState(() {
            selectedCategory = label;
          });
        },
        child: Container(
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

  Widget _buildCarousel() {
    final List<String> imgList = [
      'https://donasi.appdev.my.id/storage/sliders/oj7V6eBuELKvqLkxenzoIAoBEyks4zz5aFg1sClf.png',
      'https://donasi.appdev.my.id/storage/sliders/8fmbhBOOrC8SrzrMyjT2Tn3z3Kve2Q6vrV3THqyU.png',
    ];

    final List<Widget> imageSliders =
        imgList
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(item, fit: BoxFit.cover),
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
