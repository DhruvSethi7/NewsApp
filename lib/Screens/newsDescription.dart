import 'package:flutter/material.dart';

class NewsDescription extends StatefulWidget {
   NewsDescription({super.key,required this.authorName,required this.description,required this.imageUrl,required this.publishDate,required this.title});
  String title;
  String description;
  String publishDate;
  String imageUrl;
  String authorName;
  @override
  State<NewsDescription> createState() => _NewsDescriptionState();
}

class _NewsDescriptionState extends State<NewsDescription> {
  bool isPlaying=false;
  @override
  Widget build(BuildContext context) {
    final mediaobj=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading:IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios,color: Colors.black87,)) ,
        actions: const [
           Icon(Icons.bookmark_border,color: Colors.black,),
                        SizedBox(
                          width:10,
                        ),
                        Icon(Icons.share,color: Colors.black,),SizedBox(width: 15,)
        ],
      ),
      body: SingleChildScrollView(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(color: Colors.black,child: Image.network(widget.imageUrl)),
            Container(
              color: const Color(0xfff8f8f8),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:  10.0),
                child: Text(widget.title,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
              )),
            Padding(padding: const EdgeInsets.all(10),child: Text(widget.description,style: const TextStyle(fontSize:16,fontWeight: FontWeight.w400),),)
            ,Padding(padding: const EdgeInsets.all(10),child: SizedBox(
              width: double.infinity,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [
                Text('Published by- ${widget.authorName}',style: const TextStyle(fontWeight: FontWeight.w700),),Text(widget.publishDate)
              ],),
            ),), 
          ],
        ) ,
      ),
      floatingActionButton: Container(
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: Colors.black,
      width: 2.0, // Adjust this value as needed for the border width
    ),
  ),
  child: FloatingActionButton(
    backgroundColor: Colors.white,
    onPressed: () {
      setState(() {
        isPlaying = !isPlaying;
      });
    },
    child: Image.asset(
      isPlaying ? 'assets/Icons/speakeron.png' : 'assets/Icons/speakeroff.png',
      height: isPlaying ? 24 : 22,
    ),
  ),
)
    );
  }
}