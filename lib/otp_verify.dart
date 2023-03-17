import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasemobilenumberauthentication/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class otpverify extends StatefulWidget {

  @override
  State<otpverify> createState() => _otpverifyState();
}

class _otpverifyState extends State<otpverify> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  var code="";

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code="";
    return Scaffold(
      body: Center(
        child: Pinput(
          length: 6,
          showCursor: true,
          onChanged: (value){
            code=value;
          },
        ),
      ),
      bottomSheet:   Container(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: MaterialButton(
            minWidth: double.infinity,
            child: Text("Verify",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyApp.verify, smsCode: code);

              await auth.signInWithCredential(credential);
            },
          ),
        ),
      ),
    );
  }
}
