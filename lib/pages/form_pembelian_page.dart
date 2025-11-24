import 'package:flutter/material.dart';
import '../services/local_storage.dart';

class FormPembelianPage extends StatefulWidget {
  final Map obatMap;
  const FormPembelianPage({super.key, required this.obatMap});
  
  @override
  State<FormPembelianPage> createState() => _FormPembelianPageState();
}

class _FormPembelianPageState extends State<FormPembelianPage> {
  final qtyCtrl = TextEditingController(text: '1');
  final namaCtrl = TextEditingController();
  String metode = 'langsung';
  final resepCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  void submit() async {
    final qty = int.tryParse(qtyCtrl.text) ?? 1;

    // Validasi Input
    if (namaCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isi nama pembeli'))
      );
      return;
    }
    if (metode == 'resep' && resepCtrl.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nomor resep minimal 6 karakter'))
      );
      return;
    }

    int hargaSatuan = int.tryParse(widget.obatMap['price'].toString()) ?? 0;
    final total = hargaSatuan * qty;

    final data = {
      'buyerName': namaCtrl.text,
      'obatId': widget.obatMap['id'],
      'obatName': widget.obatMap['name'],
      'qty': qty,
      'total': total,
      'date': DateTime.now().toIso8601String(),
      'method': metode,
      'resepNumber': metode == 'resep' ? resepCtrl.text : '-',
      'note': noteCtrl.text,
      'status': 'selesai',
    };

    await DBHelper().tambahTransaksi(data);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaksi berhasil disimpan'))
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final o = widget.obatMap;
    return Scaffold(
      appBar: AppBar(title: Text('Beli: ${o['name']}')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView( 
          child: Column(
            children: [
              TextField(
                controller: namaCtrl, 
                decoration: const InputDecoration(labelText: 'Nama pembeli')
              ),
              const SizedBox(height:8),
              Text('Harga satuan: Rp ${o['price']}'),
              const SizedBox(height:8),
              TextField(
                controller: qtyCtrl, 
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Jumlah (qty)')
              ),
              const SizedBox(height:8),
              DropdownButtonFormField<String>(
                value: metode,
                items: const [
                  DropdownMenuItem(value: 'langsung', child: Text('Pembelian langsung')),
                  DropdownMenuItem(value: 'resep', child: Text('Pembelian dengan resep dokter')),
                ],
                onChanged: (v) => setState(() { metode = v!; }),
                decoration: const InputDecoration(labelText: 'Metode pembelian'),
              ),
              if (metode == 'resep') ...[
                const SizedBox(height:8),
                TextField(
                  controller: resepCtrl, 
                  decoration: const InputDecoration(labelText: 'Nomor resep dokter')
                ),
              ],
              const SizedBox(height:12),
              TextField(
                controller: noteCtrl, 
                decoration: const InputDecoration(labelText: 'Catatan (opsional)')
              ),
              const SizedBox(height:20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submit, 
                  child: const Text('Simpan Transaksi')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}