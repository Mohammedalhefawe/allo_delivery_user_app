class NewCategoryModel {
  final int id;
  final String name;
  final IconFullUrl iconFullUrl;
  final List<dynamic>
      translations; // Adjust type if translation structure is known

  NewCategoryModel({
    required this.id,
    required this.name,
    required this.iconFullUrl,
    required this.translations,
  });

  // Deserialize JSON to Category
  factory NewCategoryModel.fromJson(Map<String, dynamic> json) {
    return NewCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      iconFullUrl:
          IconFullUrl.fromJson(json['icon_full_url'] as Map<String, dynamic>),
      translations: json['translations'] as List<dynamic>,
    );
  }

  // Serialize Category to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon_full_url': iconFullUrl.toJson(),
      'translations': translations,
    };
  }
}

class IconFullUrl {
  final String? key;
  final String? path;
  final int status;

  IconFullUrl({
    required this.key,
    required this.path,
    required this.status,
  });

  // Deserialize JSON to IconFullUrl
  factory IconFullUrl.fromJson(Map<String, dynamic> json) {
    return IconFullUrl(
      key: json['key'] as String?,
      path: json['path'] as String?,
      status: json['status'] as int,
    );
  }

  // Serialize IconFullUrl to JSON
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'path': path,
      'status': status,
    };
  }
}
