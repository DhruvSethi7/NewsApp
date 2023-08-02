class News {
  String title;
  String publishedTime;
  String imageUrl;
  String webUrl;

  // Constructor
  News({required this.title, required this.publishedTime, required this.imageUrl, required this.webUrl});

  // Named constructor for creating News object from JSON
  News.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        publishedTime = json['publishedTime'],
        imageUrl = json['imageUrl'],
        webUrl = json['webUrl'];

  // Method to convert News object to JSON
  Map<String, dynamic> toJson() => {
        'title': title,
        'publishedTime': publishedTime,
        'imageUrl': imageUrl,
        'webUrl': webUrl,
      };
}
