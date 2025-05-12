import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyDonationsPage extends StatefulWidget {
  const MyDonationsPage({super.key});

  @override
  State<MyDonationsPage> createState() => _MyDonationsPageState();
}

class _MyDonationsPageState extends State<MyDonationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Riwayat Donasi Saya")),
      body: Column(children: [_buildDonationCard(), _buildDonationCard()]),
    );
  }

  Widget _buildDonationCard() {
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
                    'Sedekah Al-Qur\'an Rp40.000 = SAKSI Amal Jariyahmu',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        '02-May-2025 ',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      Text(
                        'Rp40.000',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
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
            child: const Text('Sukses', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
