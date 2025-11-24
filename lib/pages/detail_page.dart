import 'package:flutter/material.dart';
import '../services/local_storage.dart';
import 'edit_page.dart';

class DetailPage extends StatefulWidget {
  final Map transaksiMap;
  const DetailPage({super.key, required this.transaksiMap});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Map data;

  @override
  void initState() {
    super.initState();
    data = widget.transaksiMap;
  }

  void deleteTx() async {
    await DBHelper().deleteTransaksi(data['id']);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  void editTx() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditPage(transaksiMap: data)),
    );

    final db = await DBHelper().database;
    final results = await db.query('beli', where: 'id = ?', whereArgs: [data['id']]);

    if (results.isNotEmpty && mounted) {
      setState(() {
        data = results.first;
      }); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Transaksi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID Transaksi: ${data['id']}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 12),
            Text('Nama Obat: ${data['obatName']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Nama Pembeli: ${data['buyerName']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Jumlah Beli: ${data['qty']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Total Harga: Rp ${data['total']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
            const Divider(height: 24),
            Text('Metode Pembelian: ${data['method']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            if (data['method'] == 'resep') ...[
              Text('Nomor Resep: ${data['resepNumber']}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
            ],
            Text('Status: ${data['status']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            if (data['note'] != null && data['note'].toString().isNotEmpty)
              Text('Catatan: ${data['note']}', style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            
            const Spacer(),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: data['status'] == 'Dibatalkan' ? null : editTx,
                    child: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: deleteTx,
                    child: const Text('Hapus'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}