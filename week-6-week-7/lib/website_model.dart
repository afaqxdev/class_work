class FromWebSiteMidel {
  int? id;
  String? title;
  String? price;
  String? description;
  String? category;
  String? image;

  FromWebSiteMidel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
  });

  FromWebSiteMidel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'].toString();
    description = json['description'];
    category = json['category'];
    image = json['image'];
  }
}
