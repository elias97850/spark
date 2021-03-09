import 'package:flutter/material.dart';
//
import 'package:spark/UserData.dart';
import 'package:spark/constants/Colors.dart';
import 'package:spark/components/Scaffolds.dart';
import 'package:spark/components/AlertDialog.dart';
import 'package:spark/pages/account/SignInPage.dart';
//
import 'package:transition/transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///Page that checks
///1 - Checks if the user has completed the setup process of the account,
///   (a) if the user has completed the process, then it redirects it to the home page,
///   (b) if it hasn't completed the a stage, then it would redirect the user to that stage
///2 - Downloads the data of the user in the database into the UserData.vars
class InitialLoadingPage extends StatefulWidget {
  //
  static String id = 'loadingPage';
  //
  @override
  _InitialLoadingPageState createState() => _InitialLoadingPageState();
}

//TODO remember to make this the first page in the app
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
  ///Verifies if there's a user signed in,
  ///(a) if it is, it calls the getUserData();
  ///(b) if it isn't then redirects the user to the WelcomePage
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        await getUserData();
      } else {
        CustomAlertDialog(
          context: context,
          title: 'Mmm wait...',
          content: 'Seems like you aren\'t -Signed In-'
              '\nSigning out...',
        );
        Navigator.pushReplacement(
          context,
          Transition(
            child: SignInPage(), //TODO change this to the WelcomePage
            transitionEffect: TransitionEffect.leftToRight,
            curve: Curves.decelerate,
          ).builder(),
        );
      }
    } catch (e) {
      CustomAlertDialog(
        context: context,
        title: 'Mmm wait...',
        content: 'Seems like you aren\'t -Signed In-'
            '\nSigning out...',
      );
      Navigator.pushReplacement(
        context,
        Transition(
          child: SignInPage(), //TODO change this to the WelcomePage
          transitionEffect: TransitionEffect.leftToRight,
          curve: Curves.decelerate,
        ).builder(),
      );
    }
  }

  ///Downloads the user's data from the db into the UserData.vars
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
            ' name ${UserData.name} \n uid ${UserData.uid} \n email ${UserData.email} \n password ${UserData.password}'
            '\n age ${UserData.age} \n birthdate ${UserData.birthDate} \n quizCompleted ${UserData.quizCompleted}'
            '\n tagsCompleted ${UserData.tagsCompleted} \n setUpCompleted ${UserData.setUpCompleted}');
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
