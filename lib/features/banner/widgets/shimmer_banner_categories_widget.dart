import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryBannersShimmer extends StatelessWidget {
  const CategoryBannersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    double width = MediaQuery.of(context).size.width;
    double itemSize = width * 0.5;

    return Column(
      children: [
        SizedBox(
          height: itemSize,
          width: width,
          child: Shimmer.fromColors(
            baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            highlightColor: isDarkMode ? Colors.grey[500]! : Colors.grey[100]!,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3, // Match the number of carousel items
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: itemSize,
                      color: Colors.grey[300],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}