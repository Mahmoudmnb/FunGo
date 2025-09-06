class StoryModel {
  int? id;
  String? txt;
  String? image;
  String? userName;
  String? createdAt;

  StoryModel({this.id, this.txt, this.image, this.userName, this.createdAt});

  StoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    txt = json['txt'];
    image = json['image'];
    userName = json['userName'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['txt'] = txt;
    data['image'] = image;
    data['userName'] = userName;
    data['createdAt'] = createdAt;
    return data;
  }
}
