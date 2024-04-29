
import 'package:flutter/material.dart';

class textWidget extends StatelessWidget {
  const textWidget( {
    super.key,
    // required this.height,
    required this.color,
    required this.onpress,
    // required this.width,
    required this.title,
    required this.fontsize,
    required this.fontWeight,
  });

  // final double height;
  // final double width;
  final Color color;
  final Function() onpress;
  final String title;
  final double fontsize;
  final  fontWeight;
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height:height,
        // width: width,
        
        child:Text(title,
          style: 
            TextStyle(color: color,fontSize:fontsize,fontWeight: fontWeight ))
          
    );
  }
}


