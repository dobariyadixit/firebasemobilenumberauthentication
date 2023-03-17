
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'otp_verify.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  static String verify="";

  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Firebase Authentication Mobile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myNameController = TextEditingController();
  bool _showBottomSheet = true;
  var phone="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SizedBox(height: 100,),
          Container(
            height:55,
            width: MediaQuery.of(context).size.width-30,
            decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value){
                        phone="+91"+value;
                      },
                      decoration: InputDecoration(
                      border: InputBorder.none,
                        hintText: "phone"
                    ),)
                ),
              ],
            ),
          ),
          SizedBox(height: 50,),
          BottomSheet(
              onClosing: () {},
              builder: (BuildContext ctx) => Container(
                width: double.infinity,
                //height: 250,
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Container(
                    //margin: EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width-70,
                    child: Center(
                      child: Text(
                        'Send the otp',
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '${phone}',
                      verificationCompleted: (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        MyApp.verify=verificationId;
                       /* Navigator.pushNamed(context, "otp");*/
                        Navigator.push(context, MaterialPageRoute(builder: (context) => otpverify(),));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => otpverify(),));
                    setState(() {
                      _showBottomSheet = false;
                    });
                  },
                ),
              ))
        ],
      )
    );
  }
}
