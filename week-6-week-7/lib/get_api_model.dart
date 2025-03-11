class GetModel {
  int id;
  String name;
  String price;
  String description;
  String image;

  GetModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  factory GetModel.fromJson(Map<String, dynamic> data) {
    return GetModel(
        name: data['title'],
        id: data['id'],
        description: data['description'],
        image: data['image'],
        price: data['price'].toString());
  }
}
