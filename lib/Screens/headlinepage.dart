import 'package:flutter/material.dart';
import 'package:newsapp2/Models/News.dart';
import '../Widgets/appbar.dart';
class WorldNews extends StatefulWidget {
  const WorldNews({super.key});

  @override
  State<WorldNews> createState() => _WorldNewsState();
}

class _WorldNewsState extends State<WorldNews> {
  List<News>? newsList=[];

  loadvoice()async{
     print('!!!!');
     setState(() {
       
     });
  }
    @override
  initState() {
    super.initState();
    // initTts();
      loadvoice();
  }

 
  @override
  Widget build(BuildContext context) {
    final mediaobj = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: double.infinity,
              width: double.infinity,
              // padding: EdgeInsets.only(top: mediaobj.height * 0.19),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mediaobj.height * 0.12,
                  ),
                  if(newsList!.isNotEmpty)Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: mediaobj.width * 0.01, vertical: 0),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        itemCount: newsList!.length,
                        itemBuilder: (context, index) =>
                            // NewsTile(mediaObj:  mediaobj,title: newsList![index].title,imageUrl: newsList![index].imageUrl!),
                            const Text('hii')
                      ),
                    ),
                  )
                ],
              )),
          appbar(mediaobj,null) //it is my app bar
        ],
      ),
    );
  }
}

