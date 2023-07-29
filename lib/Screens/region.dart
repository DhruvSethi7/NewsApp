import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp2/Screens/language.dart';
import 'package:newsapp2/Widgets/signTile.dart';
import 'package:newsapp2/Widgets/utils.dart';
import 'package:country_picker/country_picker.dart';
class RegionSelection extends StatefulWidget {
  const RegionSelection({super.key});
   static String routeName='/regionselection';
  @override
  State<RegionSelection> createState() => _RegionSelectionState();
}

class _RegionSelectionState extends State<RegionSelection> {
  String? selectedCountry=null;
  @override
  void initState() {
    // TODO: implement initState
    // addDataToFirestore(collectionName, data)
    super.initState();
  }
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
                  'Select Your Region',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 36,
                      fontWeight: FontWeight.w700),
                ),
                addverticalSpace(mediaobj.height * 0.04),
                GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: false,
                      countryListTheme: CountryListThemeData(
                        searchTextStyle: TextStyle(
                          fontFamily: 'Anony',
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        padding: EdgeInsets.only(top: 0),
                        flagSize: 30,
                        textStyle: TextStyle(
                            fontFamily: 'Anony',
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            ),
                        bottomSheetHeight: mediaobj.height * 0.43,
                        margin: EdgeInsets.fromLTRB(mediaobj.width * 0.065, 0,
                            mediaobj.width * 0.065, mediaobj.height * 0.165),
                        inputDecoration: InputDecoration(
                          // labelText: 'Search',
                          hintText: 'Search Country',
                          hintStyle: TextStyle(
                              // color: Colors.black,
                              fontSize: 28,
                              fontFamily: 'Anony',
                              fontWeight: FontWeight.w700),
                          prefixIcon: const Icon(Icons.search,size: 35,color: Colors.black,),
                        ),
                      ),
                      onSelect: (Country country) {
                        // print('Select country: ${country.displayName}');
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('${country.displayNameNoCountryCode}')));
                        setState(() {
                          // print(country.)
                         print(country.displayNameNoCountryCode); 
                        selectedCountry=country.displayNameNoCountryCode.split( ' ')[0];  
                        });
                        
                      },
                    );
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
                            Icon(
                              Icons.public,
                              size: mediaobj.height * 0.065 * 0.8,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              selectedCountry==null?'Country':selectedCountry!,
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
      floatingActionButton:selectedCountry==null?null: FloatingActionButton(onPressed: 
      (){
        FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
        String uid=FirebaseAuth.instance.currentUser!.uid;
        FirebaseFirestore.instance.collection('Users').doc(uid).update({'country':selectedCountry});
        Navigator.pushNamed(context,LanguageSelection.routeName);
      }),
    );
  }
}
