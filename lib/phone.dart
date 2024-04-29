
import 'package:backspace/const_widgets/textfied.dart';
import 'package:backspace/const_widgets/textwidget.dart';
import 'package:backspace/otpscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final mq= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color:Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: textWidget(title:'Enter Phone Number',color: const Color.fromARGB(255, 31, 30, 30),
        fontWeight:FontWeight.w600 ,fontsize: 22,onpress:() {}),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                textWidget(title:"Enter your phone number",color: Colors.black,
                fontsize: 25,onpress:(){},fontWeight: FontWeight.bold ,),
            
                SizedBox(height: 20,),
          
                textWidget(title:"We'll send you a text verification code",color: Colors.black,
                fontsize: 18,onpress:(){},fontWeight: FontWeight.w400,),
            
                SizedBox(height: 30,),
            
                textWidget(color: const Color.fromARGB(255, 74, 73, 73), onpress: (){}, title: 'Mobile Number',
                fontsize: 15, fontWeight: FontWeight.w600),
            
                SizedBox(height: 8,),
                CustomTextFormField(controller: phoneController, hintText: "+91 Enter phone number", 
                prefixIcon: null, suffixIcon: Icon(Icons.phone), obscureText: false, 
                readonly: false, ontap: (){}, keyboardtype:TextInputType.text , errorText: null, 
                validator: (value) {
                    if(value!.isEmpty){
                          return 'Please enter Phone number';
                        }
                          
                }, onChanged:(value){}, labelText: ''),
                
                SizedBox(height: 30,),
                SizedBox(
                  width: mq.width,
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0), // Adjust the corner radius as needed
                    ),
                     // Change the text color here
                    elevation: 5, // Change the elevation here
                    // Add more properties as needed
                    ),onPressed: ()async{
                      if (_formkey.currentState!.validate()) {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      verificationCompleted: (PhoneAuthCredential credential){},
                      verificationFailed: (FirebaseAuthException ex){} , 
                      codeSent: (String verificationId, int? resendToken){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> OTPScreen(verificationId: verificationId,value: phoneController.text)));
                      },
                      codeAutoRetrievalTimeout: (String verificationId){}, phoneNumber: phoneController.text.toString() );
                          
                  }}, child: Text('Verify phone number')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




