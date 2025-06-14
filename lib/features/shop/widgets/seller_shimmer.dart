import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SellerShimmer extends StatelessWidget {
  const SellerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return const SellerCardShimmer();
      },
    );
  }
}

class SellerCardShimmer extends StatelessWidget {
  const SellerCardShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Provider.of<ThemeController>(context).darkTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,
          Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall, 0),
      child: Container(
        height: 220, // Match SellerCard height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.075),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Image Shimmer
            Container(
              height: 120,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.paddingSizeSmall),
                  topRight: Radius.circular(Dimensions.paddingSizeSmall),
                ),
              ),
              child: Shimmer.fromColors(
                baseColor: isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
                highlightColor:
                    isDarkTheme ? Colors.grey[500]! : Colors.grey[100]!,
                enabled: true,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
            // Shop Name, Address, and Circular Image Row
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: Dimensions.paddingSizeSmall,
                top: Dimensions.paddingSizeSmall,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shop Name Shimmer
                        Shimmer.fromColors(
                          baseColor: isDarkTheme
                              ? Colors.grey[700]!
                              : Colors.grey[300]!,
                          highlightColor: isDarkTheme
                              ? Colors.grey[500]!
                              : Colors.grey[100]!,
                          enabled: true,
                          child: Container(
                            height: 16,
                            width: 100,
                            color: Colors.white,
                            margin: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeExtraSmall,
                            ),
                          ),
                        ),
                        // Address Shimmer
                        Shimmer.fromColors(
                          baseColor: isDarkTheme
                              ? Colors.grey[700]!
                              : Colors.grey[300]!,
                          highlightColor: isDarkTheme
                              ? Colors.grey[500]!
                              : Colors.grey[100]!,
                          enabled: true,
                          child: Container(
                            height: 14,
                            width: 150,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Circular Shop Image Shimmer
                  Container(
                    transform: Matrix4.translationValues(10, -20, 0),
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Shimmer.fromColors(
                      baseColor:
                          isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
                      highlightColor:
                          isDarkTheme ? Colors.grey[500]! : Colors.grey[100]!,
                      enabled: true,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Product Count Shimmer
            Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.paddingSizeSmall,
                right: Dimensions.paddingSizeSmall,
                bottom: Dimensions.paddingSizeSmall,
                top: Dimensions.paddingSizeSmall,
              ),
              child: Shimmer.fromColors(
                baseColor: isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
                highlightColor:
                    isDarkTheme ? Colors.grey[500]! : Colors.grey[100]!,
                enabled: true,
                child: Container(
                  padding:
                      const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 14,
                        width: 50,
                        color: Colors.white,
                      ),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      Container(
                        height: 14,
                        width: 60,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
