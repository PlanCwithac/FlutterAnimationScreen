import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'goal.dart';

class Animationn extends StatefulWidget {
 

  @override
  _AnimationnState createState() => _AnimationnState();
}

class _AnimationnState extends State<Animationn> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.mirror,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffff1100),
                Color(0xff008eff),
              ],
              stops: [
                0,
                1,
              ],
            ),
            backgroundBlendMode: BlendMode.srcOver,
          ),
          child: Stack(
            children:[
               PlasmaRenderer(
              type: PlasmaType.infinity,
              particles: 10,
              color: Color(0x442eaeaa),
              blur: 0.31,
              size: 1,
              speed: 1.86,
              offset: 0,
              blendMode: BlendMode.plus,
              particleType: ParticleType.atlas,
              variation1: 0,
              variation2: 0,
              variation3: 0,
              rotation: 0,
            ),
              Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText('Hello',textStyle: const TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Color(0xffeee0df))),
                    RotateAnimatedText('Animation screen',textStyle: const TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Color(0xffeee0df))),
                    RotateAnimatedText('Click to get started',textStyle: const TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Color(0xffeee0df))),
                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 3000),
                  stopPauseOnTap: true,
                ),
              ),],
          ),
        ),
          onTap: () async{
          final directory= await getApplicationDocumentsDirectory();
          String path= directory.path;
          if(await File('$path/goal.txt').exists()){
            Goal.goalName=await File('$path/goal.txt').readAsStringSync();
            Goal.goalDetails=await File('$path/details.txt').readAsStringSync();
            Navigator.of(context).pushReplacementNamed('/home');

          }
          else
            Navigator.of(context).pushReplacementNamed('/goal');
          }
      ),
    );
  }
}
