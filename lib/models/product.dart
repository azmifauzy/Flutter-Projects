class Product {
  String? code;
  String? name;
  int? qty;
  String? productId;

  Product({
    required this.code,
    required this.name,
    required this.qty,
    required this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        code: json["code"] ?? "",
        name: json["name"] ?? "",
        qty: json["qty"] ?? 0,
        productId: json["productId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "qty": qty,
        "productId": productId,
      };
}
