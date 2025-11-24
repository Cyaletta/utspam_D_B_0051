class Obat {
  String id;
  String name;
  int price;

  Obat({required this.id, required this.name, required this.price});

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'price': price};
  factory Obat.fromMap(Map m) => Obat(id: m['id'], name: m['name'], price: m['price']);

  void operator [](String other) {}
}
