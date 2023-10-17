import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../data/list.dart';
import '../page/HomePage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController? controller;
  int currentIndex = 0;
  double porcentaje = 0.20;

  late bool colors = true;

  @override
  void initState(){
    controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose(){
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: listaComponents[currentIndex].background,
      body: LayoutBuilder(
        builder: (context, responsive){
          if(responsive.maxWidth <= 300){
            return Stack(
              children: [
                if (listaComponents[currentIndex].backgroundColor != null) listaComponents[currentIndex].backgroundColor,
                Expanded(
                    flex: 5,
                    child: PageView.builder(
                        controller: controller,
                        itemCount: listaComponents.length,
                        onPageChanged: (int index){
                          if (index >= currentIndex){
                            setState(() {
                              currentIndex = index;
                              porcentaje += 0.20;
                            });
                          }else{
                            setState(() {
                              currentIndex = index;
                              porcentaje -= 0.20;
                            });
                          }
                        },
                        itemBuilder: (context, index){

                          if (listaComponents[currentIndex].background == Colors.white){
                            colors = true;
                          }else{
                            colors = false;
                          }
                          if(listaComponents[index].background == Colors.white){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /*Padding(
                            padding: EdgeInsets.only(),
                            child: SvgPicture.asset(
                              listaComponents[index].image,
                              width: 260,
                              height: 260,
                            ),
                          ),*/
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
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    listaComponents[index].descripcion,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: colors ? Colors.black : Colors.white,
                                      //fontFamily: "DelaGothicOne"
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            );
                          }else{
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 60),
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
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    listaComponents[index].descripcion,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: colors ? Colors.black : Colors.white,
                                      //fontFamily: "DelaGothicOne"
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                    )
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: List.generate(
                                    listaComponents.length,
                                        (index) => buildDot(index, context)
                                ),
                              ),
                            ),
                            CupertinoButton(
                                child: Container(
                                    width: 100,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: colors ? Colors.white : Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Omitir',
                                        style: TextStyle(
                                            color: colors ? Colors.black : Colors.white,
                                            fontFamily: 'CroissantOne',
                                            fontSize: 17
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                ),
                                onPressed: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const HomePage())
                                  );
                                }
                            )
                          ],
                        ),
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 55,
                                  width: 55,
                                  child: CircularProgressIndicator(
                                    value: porcentaje,
                                    backgroundColor: colors ? Colors.grey : Colors.grey,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        colors ? Colors.white : Colors.black
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: colors ? Colors.white : Colors.black,
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: listaComponents[currentIndex].background,
                                  ),
                                )
                              ],
                            ),
                            onPressed: (){
                              if(currentIndex == listaComponents.length - 1){
                                if(porcentaje == 1){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const HomePage())
                                  );
                                }
                              }
                              controller!.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut
                              );
                            }
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }else if(responsive.maxWidth >=1000){
           return Stack(
             children: [
               if (listaComponents[currentIndex].backgroundColor != null) listaComponents[currentIndex].backgroundColor,
               Expanded(
                   flex: 5,
                   child: PageView.builder(
                       controller: controller,
                       itemCount: listaComponents.length,
                       onPageChanged: (int index){
                         if (index >= currentIndex){
                           setState(() {
                             currentIndex = index;
                             porcentaje += 0.20;
                           });
                         }else{
                           setState(() {
                             currentIndex = index;
                             porcentaje -= 0.20;
                           });
                         }
                       },
                       itemBuilder: (context, index){
                         if (listaComponents[currentIndex].background == Colors.white){
                           colors = true;
                         }else{
                           colors = false;
                         }
                         if(listaComponents[index].background == Colors.white){
                           return Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               Expanded(
                                   flex: 4,
                                   child: Padding(
                                     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                     child: Container(
                                         height: MediaQuery.of(context).size.height,
                                         decoration: BoxDecoration(
                                             image: const  DecorationImage(
                                                 image: AssetImage(
                                                     "../images/imagen4.jpg"
                                                 ),
                                                 fit: BoxFit.cover
                                             ),
                                             borderRadius: BorderRadius.circular(20)
                                         ),
                                         child: Center(
                                           child: Text(
                                             listaComponents[index].titulo,
                                             style: TextStyle(
                                                 fontSize: 30,
                                                 fontWeight: FontWeight.bold,
                                                 color: Colors.white,
                                                 fontFamily: "DelaGothicOne"
                                             ),
                                             textAlign: TextAlign.center,
                                           ),
                                         )
                                     ),
                                   )
                               ),
                               Expanded(
                                 flex: 5,
                                 child: Stack(
                                   children: [
                                     if(listaComponents[currentIndex].backgroundColor != null)
                                       listaComponents[currentIndex].backgroundColor,
                                     Center(
                                       child: Text(
                                         listaComponents[index].descripcion,
                                         style: TextStyle(
                                           fontSize: 25,
                                           color: colors ? Colors.black : Colors.white,
                                           //fontFamily: "DelaGothicOne"
                                         ),
                                         textAlign: TextAlign.center,
                                       ),
                                     )
                                   ]
                                 )
                               )
                             ],
                           );
                         }else{
                           return Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               const SizedBox(height: 30),
                               Expanded(
                                 flex: 6,
                                 child: Text(
                                   listaComponents[index].descripcion,
                                   style: TextStyle(
                                     fontSize: 25,
                                     color: colors ? Colors.black : Colors.white,
                                     //fontFamily: "DelaGothicOne"
                                   ),
                                   textAlign: TextAlign.center,
                                 ),
                               ),
                               Expanded(
                                   flex: 5,
                                   child: Padding(
                                     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                     child: Container(
                                       height: MediaQuery.of(context).size.height,
                                       decoration: BoxDecoration(
                                           image: const  DecorationImage(
                                               image: AssetImage(
                                                   "../images/imagen5.jpg"
                                               ),
                                               fit: BoxFit.cover
                                           ),
                                           borderRadius: BorderRadius.circular(20)
                                       ),
                                       child: Center(
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
                                       )
                                     ),
                                   )
                               )
                             ],
                           );
                         }
                       }
                   )
               ),
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(24.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 20),
                             child: Row(
                               children: List.generate(
                                   listaComponents.length,
                                       (index) => buildDot(index, context)
                               ),
                             ),
                           ),
                           CupertinoButton(
                               child: Container(
                                   width: 120,
                                   height: 45,
                                   decoration: BoxDecoration(
                                     color: colors ? Colors.white : Colors.black,
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                   child: Center(
                                     child: Text(
                                       'Omitir',
                                       style: TextStyle(
                                           color: colors ? Colors.black : Colors.white,
                                           fontFamily: 'CroissantOne',
                                           fontSize: 20
                                       ),
                                       textAlign: TextAlign.center,
                                     ),
                                   )
                               ),
                               onPressed: (){
                                 Navigator.of(context).push(
                                     MaterialPageRoute(builder: (context) => const HomePage())
                                 );
                               }
                           )
                         ],
                       ),
                       CupertinoButton(
                           padding: EdgeInsets.zero,
                           child: Stack(
                             alignment: Alignment.center,
                             children: [
                               SizedBox(
                                 height: 55,
                                 width: 55,
                                 child: CircularProgressIndicator(
                                   value: porcentaje,
                                   backgroundColor: colors ? Colors.grey : Colors.grey,
                                   valueColor: AlwaysStoppedAnimation<Color>(
                                       colors ? Colors.white : Colors.black
                                   ),
                                 ),
                               ),
                               CircleAvatar(
                                 backgroundColor: colors ? Colors.white : Colors.black,
                                 child: Icon(
                                   Icons.arrow_forward_ios_outlined,
                                   color: listaComponents[currentIndex].background,
                                 ),
                               )
                             ],
                           ),
                           onPressed: (){
                             if(currentIndex == listaComponents.length - 1){
                               if(porcentaje == 1){
                                 Navigator.of(context).push(
                                     MaterialPageRoute(builder: (context) => const HomePage())
                                 );
                               }
                             }
                             controller!.nextPage(
                                 duration: const Duration(milliseconds: 500),
                                 curve: Curves.easeInOut
                             );
                           }
                       )
                     ],
                   ),
                 ),
               )
             ],
           );
          }else{
            return Stack(
              children: [
                if (listaComponents[currentIndex].backgroundColor != null) listaComponents[currentIndex].backgroundColor,
                Expanded(
                    flex: 5,
                    child: PageView.builder(
                        controller: controller,
                        itemCount: listaComponents.length,
                        onPageChanged: (int index){
                          if (index >= currentIndex){
                            setState(() {
                              currentIndex = index;
                              porcentaje += 0.20;
                            });
                          }else{
                            setState(() {
                              currentIndex = index;
                              porcentaje -= 0.20;
                            });
                          }
                        },
                        itemBuilder: (context, index){

                          if (listaComponents[currentIndex].background == Colors.white){
                            colors = true;
                          }else{
                            colors = false;
                          }
                          if(listaComponents[index].background == Colors.white){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    listaComponents[index].titulo,
                                    style: TextStyle(
                                        fontSize: 37,
                                        fontWeight: FontWeight.bold,
                                        color: colors ? Colors.black : Colors.white,
                                        fontFamily: "DelaGothicOne"
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    listaComponents[index].descripcion,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: colors ? Colors.black : Colors.white,
                                      //fontFamily: "DelaGothicOne"
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            );
                          }else{
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 60),
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
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    listaComponents[index].descripcion,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: colors ? Colors.black : Colors.white,
                                      //fontFamily: "DelaGothicOne"
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                    )
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: List.generate(
                                    listaComponents.length,
                                        (index) => buildDot(index, context)
                                ),
                              ),
                            ),
                            CupertinoButton(
                                child: Container(
                                    width: 120,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: colors ? Colors.white : Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Omitir',
                                        style: TextStyle(
                                            color: colors ? Colors.black : Colors.white,
                                            fontFamily: 'CroissantOne',
                                            fontSize: 20
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                ),
                                onPressed: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const HomePage())
                                  );
                                }
                            )
                          ],
                        ),
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 55,
                                  width: 55,
                                  child: CircularProgressIndicator(
                                    value: porcentaje,
                                    backgroundColor: colors ? Colors.grey : Colors.grey,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        colors ? Colors.white : Colors.black
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: colors ? Colors.white : Colors.black,
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: listaComponents[currentIndex].background,
                                  ),
                                )
                              ],
                            ),
                            onPressed: (){
                              if(currentIndex == listaComponents.length - 1){
                                if(porcentaje == 1){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const HomePage())
                                  );
                                }
                              }
                              controller!.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut
                              );
                            }
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      )
    );
  }

  AnimatedContainer buildDot(int Index, BuildContext context){
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 8,
      width: currentIndex == Index ? 24 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == Index ? Colors.grey : Colors.grey
      ),
    );
  }
}
