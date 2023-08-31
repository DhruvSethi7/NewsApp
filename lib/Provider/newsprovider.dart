
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/News.dart';
final Map<String, List<News>> _cachedNews = {};
class NewsService {
  // Caching mechanism
  
  
  Future<List<News>> fetchNewsByCategory(String category) async {
    if (_cachedNews.containsKey(category)) {
      return _cachedNews[category]!;
    }
    List<News> articles=[];
    articles=await ApiService(category);
    _cachedNews[category] = articles;
    // print(_cachedNews);
    return articles;
  }
}
Future<List<News>> ApiService (String category)async{
  print(category);
  const String baseUrl = 'https://newsdata.io/api/1/news';
  final Dio dio = Dio();

      final response = await dio.get(
        baseUrl,
        options: Options(
          headers: {'X-ACCESS-KEY':'pub_2848047eb8285da33f8d4c7b511110ded2a47',},
        ),
        queryParameters: {
          'image':1,
          'full_content':1,
          'language':'hi',
          'category':category
          // 'timeframe':3
        },
      );
      if (response.statusCode == 200) {
        List newslist = response.data['results'];
        return newslist.map((item) => News(
          authorName:'',
          title: item['title'],
          publishedTime: item['pubDate'],
          imageUrl: item['image_url'],
          webUrl: item['link'],
          description: item['content']??'',
        )).toList();
      } 
      return [];
}    




final selectedCategoryProvider = StateProvider<String>((ref) => 'sports'); // Default category is 'Sports'

final newsCategoryProvider=Provider<List<String>>((ref) => [
    'entertainment',
    'sports',
    'business',
    'technology',
    'environment',
    'food',
    'health',
    'politics',
    'science',
    'top',
    'tourism',
    'world'
  ]);
final newsProvider = FutureProvider<List<News>>((ref) async {
  final category=ref.watch(selectedCategoryProvider);
  print('newsProvider fetching news for category: $category');
  return await NewsService().fetchNewsByCategory(category);
});