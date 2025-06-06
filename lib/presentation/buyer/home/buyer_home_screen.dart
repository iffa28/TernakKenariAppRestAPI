import 'package:canaryfarm_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomBarScreen(),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Cari produk",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push(const SearchScreen());
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 8),
                      Text("Cari"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<BarangBloc, BarangState>(
            builder: (context, state) {
              if (state is BarangLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is BarangErrorState) {
                return Center(
                  child: Text("Gagal memuat data"),
                );
              }

              if (state is BarangLoadedState) {
                final barangList = state.barangList;

                if (barangList.isEmpty) {
                  return const Center(child: Text("Tidak ada barang tersedia."));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: barangList.length,
                  itemBuilder: (context, index) {
                    final barang = barangList[index];
                    return GestureDetector(
                      onTap: () {
                        context.push(
                          DetailBarangBuyerScreen(
                            barang: barang,
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.inventory,
                                  size: 40, color: Colors.blue),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama: ${barang.namaBarang ?? ''}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Stok: ${barang.stok ?? ''}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Harga: ${barang.harga ?? ''}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Deskripsi: ${barang.deskripsi?.length ?? 0 > 20 ? '${barang.deskripsi!.substring(0, 20)}...' : barang.deskripsi ?? ''}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              return const SizedBox(); // default kosong
            },
          ),
        ],
      ),
    );
  }
}