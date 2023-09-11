import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:newsapp2/Models/News.dart';
import 'package:newsapp2/Provider/userdata.dart';
// import 'package:newsapp2/Provider/apis.dart';
import 'package:newsapp2/Widgets/category.dart';
import 'package:newsapp2/Widgets/newsList.dart';
import 'package:newsapp2/Widgets/newstile.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/appbar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex=0;
 
  List<News> news = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserDataFetcher.init();
    initTts();
  }



  initTts() {
    flutterTts = FlutterTts();
    flutterTts.setLanguage('hi-IN');
    flutterTts.setVoice({"name": "hi-in-x-hia-local", "locale": "hi-IN"});
    _setAwaitOptions();
    _getDefaultEngine();
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }
  @override
  Widget build(BuildContext context) {
    final mediaobj = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        drawer: const MyDrawer(),
        
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
                    Category(mediaobj: mediaobj),
                    const Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                     Expanded(
                        child: NewsList(mediaObj: mediaobj,)),
                  ],
                )),
            appbar(mediaobj, null) //it is my app bar
          ],
        ),
      ),
    );
  }

 
}
