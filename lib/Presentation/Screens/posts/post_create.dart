import 'package:flutter/material.dart';

import '../../../Constants/Strings.dart';

class PostCreate extends StatefulWidget {
  const PostCreate({super.key});

  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  double height (BuildContext context,double height)=> MediaQuery.sizeOf(context).height*height;
  double width (BuildContext context,double width)=> MediaQuery.sizeOf(context).width*width;
  double textFontSize (BuildContext context,double fontSize)=> MediaQuery.textScalerOf(context).scale(fontSize);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Container(
        height: height(context, 1),
        padding: EdgeInsets.only(bottom:height(context, 0.07)+10),

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundAsset),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Image.asset('assets/images/group2.png',height: height(context, 0.3),width: width(context, 1),),
            ],
          ),
        )
      ),
    );
  }


  Widget formButton({required String text,required void Function() tap})=> GestureDetector(
  onTap: tap,
  child: Container(
  height: height(context, 1/12),
  width: width(context,1/2),
  decoration: BoxDecoration(
  color: Colors.tealAccent,
  borderRadius: BorderRadius.circular(10),
  ),
  child:  Center(
  child: Text(
  text,
  style: TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: textFontSize(context, 25),
  ),
  )),
  ),
  );
}
