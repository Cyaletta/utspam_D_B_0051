import 'package:flutter/material.dart';
import '../services/local_storage.dart';
import 'detail_page.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  List<Map<String, dynamic>> list = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final data = await DBHelper().getRiwayatTransaksi();
    if (mounted) {
      setState(() {
        list = data;
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pembelian')),
      body: list.isEmpty 
        ? const Center(child: Text('Belum ada transaksi'))
        : ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          itemBuilder: (ctx, i) {
            final m = list[i];
            return Card(
              child: ListTile(
                title: Text(m['obatName'] ?? '-'),
                subtitle: Text('Rp ${m['total']} - ${m['date'].toString().split('T').first}'),
                trailing: Text(m['status'] ?? ''),
                onTap: () async {
                  await Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => DetailPage(transaksiMap: m))
                  );
                  load();
                },
              ),
            );
          },
        ),
    );
  }
}