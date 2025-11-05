import 'package:flutter/material.dart';
import 'package:store/ui/core/ui/animation_helpers/custom_shimmer.dart';

class ShimmerRow extends StatelessWidget{
  final int count;
  const ShimmerRow({super.key, this.count = 7});
  
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: count ,
      separatorBuilder: (context,index){
        return SizedBox(width: 16);
      },
      itemBuilder: (context,index){
        final double width = index.isEven ? 60 : 80;
        return CustomShimmer(
          child: Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white
            ),
          )
        );
      }
      );
  }
}