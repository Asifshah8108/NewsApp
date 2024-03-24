class Source {
  final String id;
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}


class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
   var publishedAt;
   final Source source;
   final String url;
   final String content;
   final String author;
   final String urlToSource;



  NewsArticle({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.source,
    required this.url,
    required this.content,
    required this.author,
    required this.urlToSource

  });
   bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsArticle &&
        other.title == title &&
        other.description == description &&
        other.urlToImage == urlToImage &&
        other.publishedAt == publishedAt &&
        other.source == source &&
        other.url == url &&
        other.content == content &&
        other.author == author &&
        other.urlToSource == urlToSource;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        urlToImage.hashCode ^
        publishedAt.hashCode ^
        source.hashCode ^
        url.hashCode ^
        content.hashCode ^
        author.hashCode ^
        urlToSource.hashCode;
  }
  // Overriding hashCode
  

  // Factory method to convert JSON data into NewsArticle object
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      source: json['source'] != null
        ? Source.fromJson(json['source'] as Map<String, dynamic>)
        : Source(id: '', name: ''),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt']?? '',
      author: json['author']?? '',
      content: json['content']?? '',
      url: json['url']?? '',
      urlToSource: json['urlToSource']?? ''
      // Parse other necessary fields from JSON
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'author': author,
      'content': content,
      'url': url,
      'source': source.toJson(),
      'urlToSource': urlToSource,
    };
  }
}


