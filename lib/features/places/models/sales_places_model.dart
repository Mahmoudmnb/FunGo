class SalesPlacesModel {
  int? id;
  String? title;
  String? body;
  // String? startDate;
  String? remainingdays;
  int? placeId;
  String? placeName;
  String? image;

  SalesPlacesModel(
      {this.id,
      this.title,
      this.body,
      // this.startDate,
      this.remainingdays,
      this.placeId,
      this.placeName,
      this.image});

  SalesPlacesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    // startDate = json['startDate'];
    remainingdays = json['remaining_days'];
    placeId = json['placeId'];
    placeName = json['placegovernorate'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    // data['startDate'] = startDate;
    data['remaining_days'] = remainingdays;
    data['placeId'] = placeId;
    data['placeName'] = placeName;
    data['image'] = image;
    return data;
  }
}
