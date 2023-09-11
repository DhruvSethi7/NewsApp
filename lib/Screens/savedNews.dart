import 'package:flutter/material.dart';
import 'package:newsapp2/Provider/databse.dart';
import 'package:newsapp2/Screens/newsDescription.dart';

class SavedNewsSceeen extends StatefulWidget {
  const SavedNewsSceeen({super.key});

  @override
  State<SavedNewsSceeen> createState() => _SavedNewsSceeenState();
}

class _SavedNewsSceeenState extends State<SavedNewsSceeen> {
  late Future<List<Map<String, dynamic>>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = DatabaseHelper.instance.fetchAllNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved News'),
        backgroundColor: const Color(0xff02011D),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 10),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return const Center(child: Text('An error occurred!'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No saved news found.'));
            } else {
              return ListView.builder(
                itemCount: 2 * snapshot.data!.length, // Adjusting the item count
                itemBuilder: (ctx, index) {
                  // Check if the current index is even (i.e., a news item)
                  if (index.isEven) {
                    final news = snapshot.data![index ~/ 2]; // Integer division
                    return ListTile(
                      
                      title: Text(news['title']),
                      leading: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(news['imageUrl'], fit: BoxFit.cover),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDescription(
                              authorName: news['authorName'],
                              description: news['description'],
                              imageUrl: news['imageUrl'],
                              publishDate: news['publishedTime'],
                              title: news['title'],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    // If index is odd, return a Divider
                    return const Divider(
                      color: Colors.black,
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
