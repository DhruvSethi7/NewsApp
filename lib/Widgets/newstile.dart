import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:newsapp2/Provider/databse.dart';
import 'package:newsapp2/Provider/newsprovider.dart';
import 'package:newsapp2/Screens/newsDescription.dart';

FlutterTts flutterTts = FlutterTts();

class NewsTile extends ConsumerStatefulWidget {
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
  ConsumerState<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends ConsumerState<NewsTile> {
  bool isPlaying = false;
  bool saved=false;
  FlutterTts flutterTts=FlutterTts();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final mediaobj = MediaQuery.of(context).size;
    final isBookmarked = ref.watch(bookmarkedProvider(widget.title));
    final voiceprov=ref.watch(voiceProvier);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDescription(
                      authorName: widget.authorName,
                      description: widget.description,
                      imageUrl: widget.imageUrl,
                      title: widget.title,
                      publishDate: widget.publishDate,
                    )));
      },
      child: Card(
          color: const Color(0xfff8f9f8),
          borderOnForeground: false,
          margin: const EdgeInsets.fromLTRB(10, 0, 10,10),
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
                      widget.title ,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
               
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(Icons.share),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          icon: saved ? const Icon(
                                    Icons.bookmark,
                                    color: Colors.green,
                                  )
                                : const Icon(Icons.bookmark_border_outlined),
                          onPressed: () async {
                           DatabaseHelper.instance.toggleBookmark({
                              'title': widget.title,
                              'publishedTime': widget.publishDate,
                              'imageUrl': widget.imageUrl,
                              'webUrl': "pending",
                              'description': widget.description,
                              'authorName': widget.authorName,
                            }).then((value) {
                              setState(() {
                                saved=value;
                              });
                            }
                          
                            );
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.publishDate.toString(),
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 12),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                             voiceprov.speakText(widget.title);
                            },
                            icon: Image.asset(
                              voiceprov.currentTitle==widget.title
                                  ? 'assets/Icons/speakeron.png'
                                  : 'assets/Icons/speakeroff.png',
                              height: voiceprov.currentTitle==widget.title ? 24 : 22,
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
