import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingPage extends StatelessWidget {
  const ShimmerLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Column(
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: Text('')),
              const Spacer(),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 6,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[500]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.white,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemCount: 6)
        ],
      ),
    );
  }
}
