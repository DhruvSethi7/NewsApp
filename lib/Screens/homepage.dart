import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp2/Screens/MainScreen.dart';
import 'package:newsapp2/Widgets/signOut.dart';
import '../Models/News.dart';

List<News> newsList = [
  News(
    title:
        "Kya hua agar sachin ke pas bhi aab 4 baccho ki lugai h ?hi aab 4 baccho",
    publishedTime: "2023-08-02T10:00:00",
    imageUrl: "https://example.com/news1.jpg",
    webUrl: "https://example.com/news1",
  ),
  News(
    title: "Kya hua agar sachin ke pas bhi aab 4 baccho ki lugai h ?",
    publishedTime: "2023-08-02T11:00:00",
    imageUrl: "https://example.com/news2.jpg",
    webUrl: "https://example.com/news2",
  ),
  News(
    title: "Kya hua agar sachin ke pas bhi aab 4 baccho ki lugai h ?",
    publishedTime: "2023-08-02T12:00:00",
    imageUrl: "https://example.com/news3.jpg",
    webUrl: "https://example.com/news3",
  ),
  News(
    title: "Kya hua agar sachin ke pas bhi aab 4 baccho ki lugai h ?",
    publishedTime: "2023-08-02T13:00:00",
    imageUrl: "https://example.com/news4.jpg",
    webUrl: "https://example.com/news4",
  ),
  News(
    title: "News Five",
    publishedTime: "2023-08-02T14:00:00",
    imageUrl: "https://example.com/news5.jpg",
    webUrl: "https://example.com/news5",
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = [
    'Sports',
    'Culture',
    'Business',
    'Technology',
    'Politics',
    'Science',
    'Health',
    'Environment',
    'Education',
    'Lifestyle',
    'Entertainment',
    'Real Estate',
    'Travel',
    'Automotive',
    'Opinion',
    'Weather',
    'World',
    'Local',
    'Investigations',
    'Food & Drink',
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final mediaobj = MediaQuery.of(context).size;
    return Scaffold(
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
                  CategoryTile(mediaobj),
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: mediaobj.width * 0.04, vertical: 0),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        itemCount: newsList.length,
                        itemBuilder: (context, index) =>
                            NewsTile(mediaobj, index),
                      ),
                    ),
                  )
                ],
              )),
          appbar(mediaobj) //it is my app bar
        ],
      ),
    );
  }

  Container CategoryTile(Size mediaobj) {
    return Container(
        margin: EdgeInsets.only(top: mediaobj.height * 0.12),
        height: mediaobj.height * 0.06,
        width: double.infinity,
        padding: EdgeInsets.only(top: mediaobj.height * 0.03),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          fontWeight: selectedIndex != index
                              ? FontWeight.w700
                              : FontWeight.w900),
                    )));
          },
          itemCount: categories.length,
        ));
  }
}

Container NewsTile(Size mediaobj, int index) {
  return Container(
    height: mediaobj.height * 0.2,
    width: double.infinity,
    decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: mediaobj.width * 0.62,
          height: mediaobj.height * 0.2,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: mediaobj.height * 0.03),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  newsList[index].title,
                  style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                SizedBox(
                  // color: Colors.orange,
                  height: 30,
                  width: mediaobj.width * 0.62,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        newsList[index].publishedTime,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10,
                            fontWeight: FontWeight.w200),
                      ),
                      const Spacer(),
                      const IconButton(
                          onPressed: null,
                          
                          icon: Icon(
                            Icons.bookmark_outline,
                            color: Colors.black,
                            shadows: <Shadow>[Shadow(color: Colors.black, blurRadius: 3.0)],
                            // shadows: [
                            //   Shadow(
                            //     color: Colors.black,
                            //   )
                            // ],
                          )),
                      const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.share,
                             shadows: <Shadow>[Shadow(color: Colors.black, blurRadius: 3.0)],
                            color: Colors.black,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          width: mediaobj.width * 0.3,
          height: mediaobj.width * 0.3,
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: NetworkImage(
                    'https://i0.wp.com/electrek.co/wp-content/uploads/sites/3/2022/07/Elon-Musk-Twitter-deal.jpg?w=1500&quality=82&strip=all&ssl=1',
                  ),
                  fit: BoxFit.cover),
              // color: Colors.orange,
              borderRadius: BorderRadius.circular(30)),
        )
      ],
    ),
  );
}

Container appbar(Size mediaobj) {
  return Container(
    height: mediaobj.height * 0.12,
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(mediaobj.width * 0.01, mediaobj.height * 0.05,
        mediaobj.width * 0.01, mediaobj.height * 0.04),
    decoration: BoxDecoration(
        color: const Color(0xff02011D),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(mediaobj.width * 0.05),
            bottomRight: Radius.circular(mediaobj.width * 0.05))),
    child:  Row(
      children: [
        IconButton(
            onPressed:(){
              print('Drawer');
             Scaffold.of(globalcontext!).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 40,
            )),
        // Text('Connection',style: TextStyle(color: Colors.white),),
        const Spacer(),
        const IconButton(
          icon: Icon(
            Icons.location_on,
            size: 30,
            color: Colors.white,
          ),
          onPressed: null,
        ),
        const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ))
      ],
    ),
  );
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaobj=MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: mediaobj.height*0.06),
            height:mediaobj.height*0.2,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(radius: 40,),
                const SizedBox(height: 5,),
                Text('Dhruv Sethi',style: TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03),)
              ],
            ),
          ), 
          const Divider(color: Colors.black,),
          ListTile(
            leading: SvgPicture.asset('assets/Icons/language.svg',height:mediaobj.height*0.03,width: mediaobj.width*0.005, ),
            title:  Text('Change Language',style:TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03) ,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/Icons/state.svg',height:mediaobj.height*0.03 ),
            title: Text('Change Region',style:TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03) ,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:SvgPicture.asset('assets/Icons/saved.svg',height:mediaobj.height*0.03 ),
            title: Text('Saved',style:TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03) ,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:SvgPicture.asset('assets/Icons/history.svg',height:mediaobj.height*0.03 ),
            title: Text('History',style:TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03) ,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          SizedBox(height: mediaobj.height*0.338,),
          ListTile(
            leading:SvgPicture.asset('assets/Icons/exit.svg',height:mediaobj.height*0.03 ),
            title: Text('Sign Out',style:TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03,color: const Color(0xff00E324)) ,),
            onTap: () {
             signOut();
              Navigator.pop(context);
            },
          ),
          Container(
            height: mediaobj.height*0.08,
            width: double.infinity,     
            decoration: const BoxDecoration(
               color: Color(0xff02011D),
              borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30))
            ),
            child: Center(
              child: Container(
                height:mediaobj.height*0.005,
                width: 40,
                color: const Color(0xff00E324),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LocalNews extends StatefulWidget {
  const LocalNews({super.key});

  @override
  State<LocalNews> createState() => _LocalNewsState();
}

class _LocalNewsState extends State<LocalNews> {
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
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: mediaobj.width * 0.04, vertical: 0),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        itemCount: newsList.length,
                        itemBuilder: (context, index) =>
                            NewsTile(mediaobj, index),
                      ),
                    ),
                  )
                ],
              )),
          appbar(mediaobj) //it is my app bar
        ],
      ),
    );
  }
}

class WorldNews extends StatefulWidget {
  const WorldNews({super.key});

  @override
  State<WorldNews> createState() => _WorldNewsState();
}

class _WorldNewsState extends State<WorldNews> {
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
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: mediaobj.width * 0.04, vertical: 0),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        itemCount: newsList.length,
                        itemBuilder: (context, index) =>
                            NewsTile(mediaobj, index),
                      ),
                    ),
                  )
                ],
              )),
          appbar(mediaobj) //it is my app bar
        ],
      ),
    );
  }
}

