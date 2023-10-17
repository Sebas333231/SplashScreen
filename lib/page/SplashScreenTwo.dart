import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import '../data/list.dart';
import '../page/HomePage.dart';


class SplashScreenTwo extends StatefulWidget {
  const SplashScreenTwo({Key? key}) : super(key: key);

  @override
  State<SplashScreenTwo> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> {
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;

  late bool colors = true;

  late bool boton = true;

  @override
  void initState(){
    liquidController = LiquidController();
    super.initState();
  }

  Widget _builDot(int index){
    double selectedness = Curves.easeInOut.transform(
      max(0.0, 1.0 - ((page) - index).abs()),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return Container(
      width: 10.0,
      child: Center(
        child: Material(
          color: colors ? Colors.white : Colors.black,
          type: MaterialType.circle,
          child: Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: listaComponents[page].background,
      body: Stack(
        children: [
          if (listaComponents[page].backgroundColor != null) listaComponents[page].backgroundColor,
          Expanded(
             child:  LiquidSwipe.builder(
               initialPage: page,
               itemCount: listaComponents.length,
               itemBuilder: (context, index){
                 if (listaComponents[index].background == Colors.white){
                   colors = true;
                 }else{
                   colors = false;
                 }

                 if(page < 5){

                 }else{
                   print("Error");
                 }
                 return Container(
                   width: MediaQuery.of(context).size.width,
                   color: listaComponents[index].background,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     mainAxisSize: MainAxisSize.max,
                     children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.only(left: 20, right: 20),
                         child: Text(
                           listaComponents[index].titulo,
                           style: TextStyle(
                               fontSize: 30,
                               fontWeight: FontWeight.bold,
                               color: colors ? Colors.black : Colors.white,
                               fontFamily: "DelaGothicOne"
                           ),
                           textAlign: TextAlign.center,
                         ),
                       ),
                       if(boton)
                         CupertinoButton(
                           onPressed: (){
                             Navigator.of(context).push(
                                 MaterialPageRoute(builder: (_) => const HomePage())
                             );
                           },
                           child: Container(
                             color: Colors.white,
                             width: 150,
                             height: 50,
                             child: const Text(
                               "Comenzar",
                               style: TextStyle(
                                   color: Colors.black
                               ),
                             ),
                           ),
                         )
                     ],
                   ),
                 );
               },
               positionSlideIcon: 0.8,
               slideIconWidget: Icon(
                 Icons.arrow_back_ios,
                 color: colors ? Colors.white : Colors.black,
                 size: 25,
               ),
               onPageChangeCallback: pageChangeCallback,
               waveType: WaveType.liquidReveal,
               liquidController: liquidController,
               fullTransitionValue: 880,
               enableSideReveal: true,
               preferDragFromRevealedArea: true,
               enableLoop: true,
               ignoreUserGestureWhileAnimating: true,
             ),
          ),
          Padding(
              padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(listaComponents.length, (index) => _builDot(index)),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: (){
                  liquidController.animateToPage(
                      page: listaComponents.length + 5,
                    duration: 700
                  );
                },
                child: Text(
                  "Skip"
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.01),
                  foregroundColor: colors ? Colors.white : Colors.black
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: (){
                  liquidController.jumpToPage(
                     page: liquidController.currentPage + 1 > listaComponents.length - 1
                         ? 0
                         : liquidController.currentPage + 1
                  );

                },
                child: Text(
                  "Next"
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.01),
                  foregroundColor: colors ? Colors.white : Colors.black
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  pageChangeCallback(int lpage){
    setState(() {
      page = lpage;
      if(page == 5){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const HomePage())
        );
      }
    });
  }
}
