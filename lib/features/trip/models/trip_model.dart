class TripModel {
  int? id;
  String? name;
  String? image;
  String? longitude;
  String? latitude;
  String? governorate;
  String? address;

  TripModel(
      {this.id,
      this.name,
      this.image,
      this.longitude,
      this.latitude,
      this.governorate,
      this.address});

  TripModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    governorate = json['governorate'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['governorate'] = governorate;
    data['address'] = address;
    return data;
  }
}
