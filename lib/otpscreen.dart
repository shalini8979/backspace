
// import 'package:backspace/const_widgets/textfied.dart';
// import 'package:backspace/const_widgets/textwidget.dart';
// import 'package:backspace/success.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';


// class OTPScreen extends StatefulWidget {
//   String verificationId;
//   String value;
//   OTPScreen({super.key,required this.verificationId, required this.value});

//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
//   final _formkey = GlobalKey<FormState>();
//   TextEditingController otpController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final mq= MediaQuery.of(context).size;

//     // final verificationErrorProvider = Provider.of<OTPVerificationErrorProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: textWidget(color: Color.fromARGB(255, 75, 75, 75), onpress: (){}, 
//         title: 'Verify code', fontsize: 22, fontWeight: FontWeight.w600),
//         centerTitle: true,
//       ),
//       body:
//       Form(
//         key: _formkey,

//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
                
            
//               //  r,)), Container(
//               //     height: 200,width: 250 ,
            
            
//               //     child: Image.asset('images/otp1.jpg',fit: BoxFit.cove
            
//                   SizedBox(height:30),
//                 textWidget(color: Colors.black, onpress: (){}, title: 'Enter code', fontsize: 25, fontWeight: FontWeight.bold),
//                 SizedBox(height: 10,),
//                 textWidget(color: Colors.black, onpress: (){}, title: 'Please type the verification code', fontsize: 15, fontWeight: FontWeight.w500),
//                 SizedBox(height: 5,),
//                 textWidget(color: Colors.black, onpress: (){}, title: 'sent to ${widget.value}', fontsize: 15, fontWeight: FontWeight.w500),
//                 SizedBox(height: 30,),
//                 CustomTextFormField(controller: otpController, 
//                 hintText: "Enter the OTP", prefixIcon: null, 
//                 suffixIcon: null, obscureText: true, 
//                 readonly: false, ontap: (){}, keyboardtype:TextInputType.phone,
//                 errorText: null,
//                 // verificationErrorProvider.errorMessage,
//                 validator: (value) {
//                   if(value!.isEmpty){
//                     return 'Please enter OTP';
//                   }  if(value!.length>6){
//                     return 'Invalid OTP length';
//                   }
                  
//                 }, onChanged: (value) {
//                   // verificationErrorProvider.clearErrorMessage();
                  
//                 },
//                   labelText:''),
          
//                 SizedBox(height: 30,),
//                 SizedBox(
//                   width: mq.width,
//                   height: 40,
//                   child: ElevatedButton(

//                     style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white, backgroundColor: Colors.purple,
//                         shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(2.0), // Adjust the corner radius as needed
//                         ),
//                          // Change the text color here
//                         elevation: 5, // Change the elevation here
//                         // Add more properties as needed
//                         ),
                        
//                     onPressed: ()async{
//                       if (_formkey.currentState!.validate()) {
//                     try{
//                       PhoneAuthCredential credential = await PhoneAuthProvider.credential(
//                         verificationId: widget.verificationId, smsCode: otpController.text.toString());
//                         FirebaseAuth.instance.signInWithCredential(credential).then((value){
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=> Success()));
                        
//                         });
                          
//                     }catch(ex){
//                       // verificationErrorProvider.setErrorMessage('Incorrect OTP'); // Set error message
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: Text('OTP Verification Failed'),
//                                 content: Text('The entered OTP is incorrect. Please try again.'),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text('OK'),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         }
//                       // }
                        
//                   }},child: Text('Verify OTP')),
//                 )
            
//               ],
//             ),
//           ),
//         ),
//       )
//     );
//   }
// }




// // ++++++++++++++++++++++++++++=+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



import 'dart:async';

import 'package:backspace/const_widgets/textfied.dart';
import 'package:backspace/const_widgets/textwidget.dart';
import 'package:backspace/success.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  late final String verificationId;
  final String value;

  OTPScreen({Key? key, required this.verificationId, required this.value}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  late Timer _timer;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    // Start timer for auto-resend OTP after 30 seconds
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void resendOTP() async {
    _start = 30; // Reset timer
    startTimer(); // Start timer again
    // Resend OTP logic
    // For example, you can use FirebaseAuth to resend OTP
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.value,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        widget.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color:Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: textWidget(
          color: Color.fromARGB(255, 75, 75, 75),
          onpress: () {},
          title: 'Verify code',
          
          fontsize: 22,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                textWidget(
                  color: Colors.black,
                  onpress: () {},
                  title: 'Enter code',
                  fontsize: 25,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10),
                textWidget(
                  color: Colors.black,
                  onpress: () {},
                  title: 'Please type the verification code',
                  fontsize: 15,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5),
                textWidget(
                  color: Colors.black,
                  onpress: () {},
                  title: 'sent to ${widget.value}',
                  fontsize: 15,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 30),
                CustomTextFormField(
                  controller: _otpController,
                  hintText: "Enter the OTP",
                  prefixIcon: null,
                  suffixIcon: null,
                  obscureText: true,
                  readonly: false,
                  ontap: () {},
                  keyboardtype: TextInputType.phone,
                  errorText: '',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter OTP';
                    } else if (value.length != 6) {
                      return 'Invalid OTP length';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  labelText: '',
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Resend OTP in $_start seconds',
                      style: TextStyle(color: Colors.grey,fontSize: 13),
                      
                    ),
                    InkWell(
                      onTap: _start == 0 ? resendOTP : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Resend',
                          style: TextStyle(color: Colors.purple,fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: mq.width,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: _otpController.text,
                          );
                          await FirebaseAuth.instance.signInWithCredential(credential);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Success()));
                        } catch (ex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('OTP Verification Failed',style: TextStyle(fontSize: 18,color: Colors.purple),),
                                content: Text('The entered OTP is incorrect. Please try again.'),
                                actions: [
                                  ElevatedButton(
                                    
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:Colors.purple,
                                      foregroundColor: Colors.white,
                                      ),
                                    onPressed: () {
                                      
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK',style: TextStyle(color: Colors.white),),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Text('Verify OTP'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
