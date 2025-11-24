import 'package:flutter/material.dart';
import '../services/local_storage.dart';

class EditPage extends StatefulWidget {
  final Map transaksiMap;
  const EditPage({super.key, required this.transaksiMap});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController qtyCtrl;
  late TextEditingController noteCtrl;
  late TextEditingController resepCtrl;
  String metode = 'langsung';

  @override
  void initState() {
    super.initState();
    qtyCtrl = TextEditingController(text: widget.transaksiMap['qty'].toString());
    noteCtrl = TextEditingController(text: widget.transaksiMap['note'] ?? '');
    resepCtrl = TextEditingController(text: widget.transaksiMap['resepNumber'] ?? '');
    metode = widget.transaksiMap['method'] ?? 'langsung';
  }

  void save() async {
    final qty = int.tryParse(qtyCtrl.text) ?? 1;
    if (qty < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah minimal 1')),
      );
      return;
    }

    if (metode == 'resep') {
      String noResep = resepCtrl.text;
      if (noResep.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nomor resep minimal 6 karakter')),
        );
        return;
      }
      bool hasLetter = noResep.contains(RegExp(r'[a-zA-Z]'));
      bool hasDigit = noResep.contains(RegExp(r'[0-9]'));
      if (!hasLetter || !hasDigit) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nomor resep harus kombinasi huruf dan angka')),
        );
        return;
      }
    }

    int oldTotal = int.tryParse(widget.transaksiMap['total'].toString()) ?? 0;
    int oldQty = int.tryParse(widget.transaksiMap['qty'].toString()) ?? 1;
    int hargaSatuan = oldQty > 0 ? oldTotal ~/ oldQty : 0;
    int newTotal = hargaSatuan * qty;

    final updated = Map<String, dynamic>.from(widget.transaksiMap);
    updated['qty'] = qty;
    updated['note'] = noteCtrl.text;
    updated['method'] = metode;
    updated['resepNumber'] = metode == 'resep' ? resepCtrl.text : '-';
    updated['total'] = newTotal;

    await DBHelper().updateTransaksi(updated['id'], updated);
    
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Transaksi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: qtyCtrl, 
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Jumlah (qty)', border: OutlineInputBorder())
            ),
            const SizedBox(height: 12),
            
            DropdownButtonFormField<String>(
              value: metode,
              items: const [
                DropdownMenuItem(value: 'langsung', child: Text('Pembelian langsung')),
                DropdownMenuItem(value: 'resep', child: Text('Pembelian dengan resep dokter')),
              ],
              onChanged: (v) => setState(() { metode = v!; }),
              decoration: const InputDecoration(labelText: 'Metode pembelian', border: OutlineInputBorder()),
            ),
            
            if (metode == 'resep') ...[
              const SizedBox(height: 12),
              TextField(
                controller: resepCtrl, 
                decoration: const InputDecoration(
                  labelText: 'Nomor Resep (Huruf & Angka)', 
                  border: OutlineInputBorder(),
                  helperText: 'Min 6 karakter'
                )
              ),
            ],
            
            const SizedBox(height: 12),
            TextField(
              controller: noteCtrl, 
              decoration: const InputDecoration(labelText: 'Catatan', border: OutlineInputBorder())
            ),
            
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: save, child: const Text('Simpan Perubahan')),
            ),
          ],
        ),
      ),
    );
  }
}