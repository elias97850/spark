import 'package:flutter/material.dart';
//
import 'package:spark/UserData.dart';
import 'package:spark/constants/Colors.dart';
import 'package:spark/components/Scaffolds.dart';
//
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InitialLoadingPage extends StatefulWidget {
  @override
  _InitialLoadingPageState createState() => _InitialLoadingPageState();
}

class _InitialLoadingPageState extends State<InitialLoadingPage> {
  //
  //Database vars
  //
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  //
  //Database Functions
  //
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        await getUserData();
      }
    } catch (e) {
      //TODO handle error by understanding the (e)
    }
  }

  void getUserData() async {
    try {
      final userDocs = await _firestore.collection('users').where('uid', isEqualTo: loggedInUser.uid).get();

      for (var doc in userDocs.docs) {
        print(doc.data);
        UserData.name = doc.data()['name'];
        UserData.age = doc.data()['age'];
        UserData.birthDate = doc.data()['birthDate'];
        //TODO then check where the user left off (with quizCompleted, tagsCompleted, setUpCompleted)
        //TODO to be able to choose where to redirect the user after SignIn
        // if 'quizCompleted == true' then pull the data that the Quiz generates
        // the same with 'tagsCompleted' & 'setUpCompleted'
        UserData.quizCompleted = doc.data()['quizCompleted'];
        UserData.tagsCompleted = doc.data()['tagsCompleted'];
        UserData.setUpCompleted = doc.data()['setUpCompleted'];
        // User.personality = doc.data['personality'];
        // User.personalityPicNum = doc.data['personalityPicNum'];
        // User.location = doc.data['location'];
        // User.latitude = User.location.latitude;
        // User.longitude = User.location.longitude;
        // User.color = Color(int.parse(doc.data['color']));
        // User.lightColor = Color(int.parse(doc.data['lightColor']));
        // User.gender = doc.data['gender'];
        // User.sexuality = doc.data['sexuality'];
        // User.lookingFor = doc.data['lookingFor'];
        // User.bio = doc.data['bio'];
        // User.workOrStudy = doc.data['workOrStudy'];
        // User.workOrStudyName = doc.data['workOrStudyName'];
        // User.hobbies = doc.data['hobbies'];
        // User.musicTaste = doc.data['musicTaste'];
        // User.entertainmentTaste = doc.data['entertainmentTaste'];
        // User.perfectDay = doc.data['perfectDay'];
        // User.favoriteFood = doc.data['favoriteFood'];
        // User.bucketList = doc.data['bucketList'];
        // User.petPeeves = doc.data['petPeeves'];
        // User.currentMood = doc.data['currentMood'];
        // User.school = doc.data['school'];
        // User.dressingStyle = doc.data['dressingStyle'];
        // User.favoritePlace = doc.data['favoritePlace'];
        // User.fondestMemory = doc.data['fondestMemory'];
        // User.guiltyPleasure = doc.data['guiltyPleasure'];
        // User.dreamJob = doc.data['dreamJob'];
        // User.bestAdvice = doc.data['bestAdvice'];
        // User.apocalypsePlan = doc.data['apocalypsePlan'];
        // User.uid = doc.data['uid'];
        // User.swipedMatchingUidsMap = doc.data['swipedUsers'];
        // User.chatsIDList = doc.data['chatList'];
        // print(User.swipedMatchingUidsMap);
        print(
            ' name ${UserData.name} \n uid ${UserData.uid} \n email ${UserData.email} \n password ${UserData.password} \n age ${UserData.age} '
            '\n birthdate ${UserData.birthDate} '
            '\n quizCompleted ${UserData.quizCompleted} \n tagsCompleted ${UserData.tagsCompleted} \n setUpCompleted ${UserData.setUpCompleted}');
      }
    } catch (e) {
      //TODO handle error by understanding the (e)
    }
  }

  //
  //Build
  //
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: kAppBackgroundColor,
      statusBarColor: kAppBackgroundColor,
      statusBarIconBrightness: Brightness.light,
      child: Center(
        child: Container(
          color: kSparkHeaderRed,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
