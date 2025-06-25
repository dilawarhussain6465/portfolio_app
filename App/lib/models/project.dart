class Project {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String category;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? webUrl;
  final String? videoUrl;
  final bool isFeatured;
  final DateTime releaseDate;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    required this.category,
    this.playStoreUrl,
    this.appStoreUrl,
    this.webUrl,
    this.videoUrl,
    this.isFeatured = false,
    required this.releaseDate,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      technologies: List<String>.from(json['technologies']),
      category: json['category'],
      playStoreUrl: json['playStoreUrl'],
      appStoreUrl: json['appStoreUrl'],
      webUrl: json['webUrl'],
      videoUrl: json['videoUrl'],
      isFeatured: json['isFeatured'] ?? false,
      releaseDate: DateTime.parse(json['releaseDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'technologies': technologies,
      'category': category,
      'playStoreUrl': playStoreUrl,
      'appStoreUrl': appStoreUrl,
      'webUrl': webUrl,
      'videoUrl': videoUrl,
      'isFeatured': isFeatured,
      'releaseDate': releaseDate.toIso8601String(),
    };
  }
}