import 'package:flutter/material.dart';

class Badgee extends StatelessWidget{
  final Widget child;
  final String value;
  final Color? color;

  const Badgee ({ 
    Key? key,
    required this.child,
    required this.value,
    this.color
  }) : super(key: key);

  @override
  Widget build (BuildContext){
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            alignment: Alignment.center,
            height: 17,
            width: 17,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12
              ),
            ),
          )
        )
      ],
    );
  }
}