class FavoriteModel {
  int? id;
  String? name;
  String? image;
  String? address;
  int? reviewAvarge;

  FavoriteModel(
      {this.id, this.name, this.image, this.address, this.reviewAvarge});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    address = json['address'];
    reviewAvarge = json['reviewAvarge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['address'] = address;
    data['reviewAvarge'] = reviewAvarge;
    return data;
  }
}
