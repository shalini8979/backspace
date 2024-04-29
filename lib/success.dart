import 'package:backspace/article_listt.dart';
import 'package:backspace/const_widgets/textwidget.dart';
import 'package:flutter/material.dart';


class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<Success> {

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
        title: textWidget(title:'',color: const Color.fromARGB(255, 31, 30, 30),
        fontWeight:FontWeight.w600 ,fontsize: 22,onpress:() {}),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Center(
              child: Container(
                height: 100,width: 100,
                      
                      
                child: Image.asset('images/success2.jpg',fit: BoxFit.cover,)),
            ),
            SizedBox(height: 20,),
        
            Center(
              child: textWidget(title:"Success!!!",color: Colors.black,
              fontsize: 28,onpress:(){},fontWeight: FontWeight.bold ,),
            ),
        
            SizedBox(height: 10,),
        
            Padding(
              padding: const EdgeInsets.only(right: 20.0,left: 20),
              child: Center(
                child: textWidget(title:"Congratulations! you have been ",color: Colors.black,
                fontsize: 18,onpress:(){},fontWeight: FontWeight.w400,),
              ),
            ),

            SizedBox(height: 4,),

            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
              child: Center(
                child: textWidget(title:"successfully authenticated ",color: Colors.black,
                fontsize: 18,onpress:(){},fontWeight: FontWeight.w400,),
              ),
            ),
          
            SizedBox(height: 10,),
        
            SizedBox(height: 30,),
        
            
        
            SizedBox(height: 15,),
          
            SizedBox(height: 30,),
            SizedBox(
              height: 40,width: mq.width,
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Adjust the corner radius as needed
                ),
                 // Change the text color here
                elevation: 5, // Change the elevation here
                // Add more properties as needed
                ),onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> 
                  Homescreen()));
                // await FirebaseAuth.instance.verifyPhoneNumber(
                //   verificationCompleted: (PhoneAuthCredential credential){},
                //   verificationFailed: (FirebaseAuthException ex){} , 
                //   codeSent: (String verificationId, int? resendToken){
                //     Navigator.push(context,MaterialPageRoute(builder: (context)=> OTPScreen(verificationId: verificationId,)));
                //   },
                //   codeAutoRetrievalTimeout: (String verificationId){}, phoneNumber: phoneController.text.toString() );
                      
              }, child: Text('Continue')),
            )
          ],
        ),
      ),
    );
  }
}




