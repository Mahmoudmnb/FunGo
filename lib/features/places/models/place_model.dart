class PlaceModel {
  int? id;
  String? name;
  String? address;
  String? description;
  List<Images>? images;
  List<Activites>? activites;
  double? reviewAvarge;
  List<Stories>? stories;

  PlaceModel(
      {this.id,
      this.name,
      this.address,
      this.description,
      this.images,
      this.activites,
      this.reviewAvarge,
      this.stories});

  PlaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['activites'] != null) {
      activites = <Activites>[];
      json['activites'].forEach((v) {
        activites!.add(Activites.fromJson(v));
      });
    }
    reviewAvarge = json['reviewAvarge'];
    if (json['stories'] != null) {
      stories = <Stories>[];
      json['stories'].forEach((v) {
        stories!.add(Stories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (activites != null) {
      data['activites'] = activites!.map((v) => v.toJson()).toList();
    }
    data['reviewAvarge'] = reviewAvarge;
    if (stories != null) {
      data['stories'] = stories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? original;

  Images({this.original});

  Images.fromJson(Map<String, dynamic> json) {
    original = json['original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['original'] = original;
    return data;
  }
}

class Activites {
  int? id;
  String? name;
  String? minPrice;
  String? maxPrice;
  int? priceAverage;

  Activites(
      {this.id, this.name, this.minPrice, this.maxPrice, this.priceAverage});

  Activites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    priceAverage = json['priceAverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['minPrice'] = minPrice;
    data['maxPrice'] = maxPrice;
    data['priceAverage'] = priceAverage;
    return data;
  }
}

class Stories {
  int? storyId;
  String? txt;
  List<String>? image;
  String? userName;
  String? createdAt;

  Stories({this.storyId, this.txt, this.image, this.userName, this.createdAt});

  Stories.fromJson(Map<String, dynamic> json) {
    storyId = json['story_id'];
    txt = json['txt'];
    image = json['image'].cast<String>();
    userName = json['user_name'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['story_id'] = storyId;
    data['txt'] = txt;
    data['image'] = image;
    data['user_name'] = userName;
    data['createdAt'] = createdAt;
    return data;
  }
}
