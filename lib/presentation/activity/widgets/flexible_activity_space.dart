import 'package:flutter/material.dart';

class FlexibleActivitySpace extends StatelessWidget {
  const FlexibleActivitySpace({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return FlexibleSpaceBar(
        background: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: height*0.08),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: height*0.16,
                  width: width*0.6,
                  child: Image.asset("assets/shop.png",fit: BoxFit.fill,),),
              ),
            ),
              Padding(
              padding: EdgeInsets.only(top: height*0.01, right: height*0.03),
              child: Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: height*0.16,
                  width: width*0.45,
                  child: Image.asset("assets/tv.png",fit: BoxFit.fill,),),
              ),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 20, bottom: 10),
        title: Row(
          children: [
            Text(
              "Shop",
              textScaler: const TextScaler.linear(2),
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),const Spacer(),
            Text(
              "20",
              textScaler: const TextScaler.linear(2),
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith( fontWeight: FontWeight.bold, fontSize: 18),),
                   SizedBox(width: height*0.005,),

                   Padding(
                     padding:  EdgeInsets.only(right: height*0.01),
                     child: Transform.scale(scale: 2,child: Icon(Icons.attach_money, color: Colors.green,)),
                   )
          ],
        ));
  }
}
