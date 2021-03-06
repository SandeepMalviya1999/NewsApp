class SourceModel {
  late String status;
  late List<Sources>? sources;

  SourceModel({required this.status, required this.sources});

  SourceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['sources'] != null) {
      sources = [];
      json['sources'].forEach((v) {
        sources!.add(Sources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['sources'] = sources!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Sources {
  late String id;
  late String name;
  late String description;
  late String url;
  late String category;
  late String language;
  late String country;

  Sources(
      {required this.id,
      required this.name,
      required this.description,
      required this.url,
      required this.category,
      required this.language,
      required this.country});

  Sources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
    category = json['category'];
    language = json['language'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['url'] = url;
    data['category'] = category;
    data['language'] = language;
    data['country'] = country;
    return data;
  }
}
