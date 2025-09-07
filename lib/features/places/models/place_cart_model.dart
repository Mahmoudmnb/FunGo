class PlaceCartModel {
  int? id;
  String? name;
  double? rating;
  String? image;
  String? address;
  bool isFavorite = false;

  PlaceCartModel({
    this.id,
    this.name,
    this.rating,
    this.image,
    this.address,
    this.isFavorite = false,
  });

  PlaceCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'] != null ? json['rating'] + 0.0 : json['rating'];
    image = json['image'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rating'] = rating;
    data['image'] = image;
    data['address'] = address;
    return data;
  }
}
