
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp2/Screens/homepage.dart';
import 'package:newsapp2/Widgets/utils.dart';
class LanguageSelection extends StatefulWidget {
  // const RegionSelection({super.key});
  static String routeName='/languageselection';
  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
   String? selectedLanguage;
   
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
  @override
  Widget build(BuildContext context) {
    final mediaobj = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: mediaobj.height * 0.17,
            decoration: BoxDecoration(
                color: Color(0xff02011d),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff000000).withOpacity(0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4)
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(mediaobj.width / 4),
                    bottomRight: Radius.circular(mediaobj.width / 4))),
          ),
          Positioned(
            top: mediaobj.height * 0.17 - mediaobj.width * 0.19,
            left: mediaobj.width / 2 - mediaobj.width * 0.19,
            child: Container(
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff000000).withOpacity(0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4)
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: mediaobj.width * 0.19,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                top: mediaobj.height * 0.17 +
                    mediaobj.width * 0.19 / 2 +
                    mediaobj.height * 0.1),
            child: Column(
              children: [
                Text(
                  'Select Your Language',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
                addverticalSpace(mediaobj.height * 0.04),
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder:(context){
                      return Dialog(
                        insetPadding: EdgeInsets.only(top: mediaobj.height*0.27),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            width: 2
                          )
                        ),
                        child:Container(
                          height: mediaobj.height*0.5,
                          width: mediaobj.width*0.9,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: ListView.builder(itemBuilder: (context,index){
                                  return GestureDetector(
                                    onTap: (){
                                      selectedLanguage=languages[index];
                                      setState(() {
                                      Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      height: mediaobj.height*0.08,
                                      width: double.infinity,
                                      child: Center(child: Text(languages[index]),
                                      ),
                                      decoration: BoxDecoration(
                                        border:Border(bottom: BorderSide()),
                                        // borderRadius: BorderRadius.circular(20),
                                        
                                                                  
                                      ),
                                    ),
                                  );
                            },itemCount: languages.length,
                            ),
                          ),
                        ),
                      );
                    });
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.black, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        color: Color(0xff00E324),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        width: mediaobj.width * 0.87,
                        height: mediaobj.height * 0.065,
                        child: Row(
                          children: [
                           
                            SvgPicture.asset('assets/Icons/language.svg',height: mediaobj.height * 0.065 * 0.7,),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              selectedLanguage==null?'':selectedLanguage!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Anony',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/Icons/drop.svg'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
      
      floatingActionButton:selectedLanguage==null?null: FloatingActionButton(
         child: CircleAvatar(radius:26,backgroundColor: Color(0xff00E324),child: Icon(color: Colors.white,Icons.arrow_forward_rounded,size: 35,)),
       
        backgroundColor: Colors.black,
       
        onPressed: (){
        FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
        String uid=FirebaseAuth.instance.currentUser!.uid;
        FirebaseFirestore.instance.collection('Users').doc(uid).update({'language':selectedLanguage});
        Navigator.pushNamed(context,HomePage.routeName);
      }),
    );
  }
}
