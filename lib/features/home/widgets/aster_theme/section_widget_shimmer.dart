import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSectionWidget extends StatelessWidget {
  const ShimmerSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: 3, // You can adjust this count
        itemBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width / 3.5,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: ShimmerCategoryCard(),
            ),
          );
        },
      ),
    );
  }
}

class ShimmerCategoryCard extends StatelessWidget {
  const ShimmerCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.all(Dimensions.paddingSizeExtraExtraSmall),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 50,
                height: 12,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Container(
                width: 70,
                height: 10,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
