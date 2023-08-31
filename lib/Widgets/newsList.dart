import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:newsapp2/Models/News.dart';
import 'package:newsapp2/Provider/newsprovider.dart';
import 'package:newsapp2/Widgets/newstile.dart';
class NewsList extends ConsumerWidget {
  final mediaObj;
  const NewsList({super.key,required this.mediaObj});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(selectedCategoryProvider);
    print('builder');
    AsyncValue<List<News>> news=ref.watch(newsProvider);
    return news.when(data: (news){
           return ListView.builder(
                      padding: const EdgeInsets.only(top: 0),
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        final newsItem = news[index];
                        // Render your news itFem here. For example:
                        return NewsTile(
                          authorName:newsItem.authorName,
                          mediaObj: mediaObj,
                          title: newsItem.title,
                          imageUrl: newsItem.imageUrl,
                          description: newsItem.description,
                          publishDate: newsItem.publishedTime,
                        );
                      },
                    );
    }, error:(_,stc){
      return const Text('Error');
    }, loading: () => const Center(child: CircularProgressIndicator()),) ;
  }
}
