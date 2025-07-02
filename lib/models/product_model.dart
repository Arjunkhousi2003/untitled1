class Product {
  final String id;
  final String name;
  final double price;
  final String? imagePath;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      imagePath: json['imagePath'],
    );
  }
}
