import 'package:flutter/material.dart';
import 'form_pembelian_page.dart'; // Pastikan import ini ada

class ListObatPage extends StatefulWidget {
  const ListObatPage({super.key});

  @override
  State<ListObatPage> createState() => _ListObatPageState();
}

class _ListObatPageState extends State<ListObatPage> {
  final List<Map<String, dynamic>> dummyobat = [
    {
      'id': 1,
      'name': 'Paracetamol 500mg',
      'price': 5000,
    },
    {
      'id': 2,
      'name': 'Amoxicillin',
      'price': 12000,
    },
    {
      'id': 3,
      'name': 'Vitamin C 1000mg',
      'price': 2500,
    },
    {
      'id': 4,
      'name': 'Obat Batuk Sirup',
      'price': 15000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Obat')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: dummyobat.length,
        itemBuilder: (ctx, i) {
          final o = dummyobat[i];
          
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text(o['name']), 
              subtitle: Text('Rp ${o['price']}'),
              leading: const Icon(Icons.medication), 
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FormPembelianPage(obatMap: o),
                    ),
                  );
                },
                child: const Text('Beli'),
              ),
            ),
          );
        },
      ),
    );
  }
}