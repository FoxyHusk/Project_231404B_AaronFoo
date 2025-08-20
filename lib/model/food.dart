class Food {
  String? uid;
  String? name;
  String? price;
  String? quantity;
  String? description;

  Food({this.uid, this.name, this.price, this.quantity, this.description});

  Food.fromMap(Map<String, dynamic> data) {
  uid = data['uid'];
  name = data['name'];
  price = data['price'];
  quantity = data['quantity'];
  description = data['description'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'price': price,
      'quantity': quantity,
      'description': description,
    };
  }
}