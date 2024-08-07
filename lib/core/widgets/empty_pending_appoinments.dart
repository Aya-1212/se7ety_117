import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/utils/text_style.dart';

class EmptyPendingAppoinments extends StatelessWidget {
  const EmptyPendingAppoinments({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      SvgPicture.asset("assets/no_scheduled.svg",height: 200,width: 200,),
      const Gap(20),
      Text("لا يوجد حجوزات حاليا",style: getTitleStyle(),),
    ],),);
  }
}