class FunnyThingsData {
  final String title; // 标题
  final String description; // 基础描述
  final List<String> tags; // 分类标签
  final String imageUrl; // 图片链接
  final String? thumbnailUrl; // 缩略图链接
  
  FunnyThingsData({
    required this.title,
    required this.description,
    required this.tags,
    required this.imageUrl,
    this.thumbnailUrl,
  });

  // 从JSON转换为对象
  factory FunnyThingsData.fromJson(Map<String, dynamic> json) {
    return FunnyThingsData(
      title: json['title'] as String,
      description: json['description'] as String,
      tags: List<String>.from(json['tags']),
      imageUrl: json['imageUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );
  }

  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'tags': tags,
      'imageUrl': imageUrl,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  // 复制对象并修改部分属性
  FunnyThingsData copyWith({
    String? title,
    String? description,
    List<String>? tags,
    String? imageUrl,
    String? thumbnailUrl,
  }) {
    return FunnyThingsData(
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}
