class Transaksi {
  String id;
  String buyerName;
  String obatId;
  String obatName;
  int qty;
  int total;
  String date;
  String method; // langsung / resep
  String? resepNumber;
  String? note;
  String status; // selesai / dibatalkan

  Transaksi({
    required this.id,
    required this.buyerName,
    required this.obatId,
    required this.obatName,
    required this.qty,
    required this.total,
    required this.date,
    required this.method,
    this.resepNumber,
    this.note,
    this.status = 'selesai',
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'buyerName': buyerName,
    'obatId': obatId,
    'obatName': obatName,
    'qty': qty,
    'total': total,
    'date': date,
    'method': method,
    'resepNumber': resepNumber,
    'note': note,
    'status': status,
  };

  factory Transaksi.fromMap(Map m) => Transaksi(
    id: m['id'],
    buyerName: m['buyerName'],
    obatId: m['obatId'],
    obatName: m['obatName'],
    qty: m['qty'],
    total: m['total'],
    date: m['date'],
    method: m['method'],
    resepNumber: m['resepNumber'],
    note: m['note'],
    status: m['status'] ?? 'selesai',
  );
}
