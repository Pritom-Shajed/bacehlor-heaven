class PostModel {
  String? uid;
  String? location;
  String? price;
  String? category;
  String? pictureUrl;

  PostModel({
    required this.uid,
    required this.location,
    required this.price,
    required this.category,
    required this.pictureUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'location': location,
      'price': price,
      'category': category,
      'pictureUrl': pictureUrl,
    };
  }
}
