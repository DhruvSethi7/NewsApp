import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:newsapp2/Screens/newsDescription.dart';

FlutterTts flutterTts = FlutterTts();

class NewsTile extends StatefulWidget {
  final Size mediaObj;
  final String authorName;
  final String title;
  final String imageUrl;
  final String description;
  final String publishDate;
  const NewsTile(
      {super.key,
      required this.authorName,
      required this.mediaObj,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.publishDate});
          
  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    final mediaobj = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDescription(
                      authorName: widget.authorName,
                      description:
                          widget.description,
                      imageUrl: widget.imageUrl,
                      title: widget.title,
                      publishDate:widget.publishDate,
                    )));
      },
      child: Card(
          
          color: const Color(0xfff8f9f8),
          borderOnForeground: false,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                      height: mediaobj.height * 0.2,
                      width: double.infinity,
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.title + widget.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 15,
                  // )  ,
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(Icons.share),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(Icons.bookmark_border_outlined),
                        const SizedBox(
                          width: 5,
                        ),
                         Text(
                          widget.publishDate.toString(),
                          style: const TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isPlaying = !isPlaying;
                                print(isPlaying);
                              });
                            },
                            icon: Image.asset(
                              isPlaying
                                  ? 'assets/Icons/speakeron.png'
                                  : 'assets/Icons/speakeroff.png',
                              height: isPlaying ? 24 : 22,
                            ))
                        // Icon(Icons.speak)
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
