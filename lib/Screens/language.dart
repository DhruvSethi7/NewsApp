import 'package:flutter/material.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  List languages = [
    'English',
    'German',
    'Arabic',
    'Spanish',
    'French',
    'Hebrew',
    'Italian',
    'Chinese',
    'Russian',
    'Swedish',
    'Norwegian',
    'Portuguese'
  ];
  int? selectedindex;
  @override
  Widget build(BuildContext context) {
    final mediaObj = MediaQuery.of(context).size;
    final appBarHeight = mediaObj.height * 0.20;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                0, appBarHeight + mediaObj.width * 0.38 / 2 + 30, 0, 10),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Your Language',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing:15,
                        mainAxisSpacing: 15,
                          crossAxisCount: 2,),
                      itemCount: languages.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedindex=index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: selectedindex==null?null:selectedindex==index?const Color(0xff00e324):null,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text(languages[index])),
                        ),
                      ),
                    ),
                  ),
                )
                
              ],
            ),
          ),
           if(selectedindex!=null)Align(
          alignment: Alignment.bottomCenter,
          child: Container(
                      width: 150,
                      height: 43,
                      margin:const EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                         color: const Color(0xff00E324),
                        border:Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      child: const Center(child: Text('NEXT',style: TextStyle(
                        fontSize: 24,
                        color: Colors.white
                      ),)),
                    )),
          Container(
            height: appBarHeight,
            decoration: const BoxDecoration(
              color: Color(0xFF090815),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(120, 120),
              ),
            ),
          ),
          Positioned(
            top: appBarHeight -
                mediaObj.width *
                    0.38 /
                    2, // Here, 50 is the radius of CircleAvatar.
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: mediaObj.width * 0.38 / 2, // Modify radius as needed
              backgroundColor: Colors.grey, // Modify color as needed
            ),
          )
        ],
      ),
    );
  }
}
