
import 'package:flutter/material.dart';

class elevatedButtonWidget extends StatelessWidget {
  const elevatedButtonWidget({
    super.key,
    required this.height,
    required this.color,
    required this.onpress,
    required this.width,
    required this.title,
    required this.fontsize,
  });

  final double height;
  final double width;
  final Color color;
  final Function() onpress;
  final String title;
  final double fontsize;
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:height,
        width: width,
        
        child:ElevatedButton(
           
            style: ElevatedButton.styleFrom(backgroundColor:color, ),
            onPressed:onpress,
            
            child: Text(title,
              style: 
                TextStyle(color: Colors.white,fontSize:fontsize,)))
          
    );
  }
}


