import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/enums/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BestSellingProductListWidget extends StatefulWidget {
  final bool isHomePage;
  final ProductType productType;
  final String productTypeString; // 'store' or 'restaurant'
  final ScrollController? scrollController;

  const BestSellingProductListWidget({
    super.key,
    required this.isHomePage,
    required this.productType,
    required this.productTypeString,
    this.scrollController,
  });

  @override
  State<BestSellingProductListWidget> createState() =>
      _BestSellingProductListWidgetState();
}

class _BestSellingProductListWidgetState
    extends State<BestSellingProductListWidget> {
  @override
  void initState() {
    super.initState();
    // Fetch best-selling products for store or restaurant
    Provider.of<ProductController>(context, listen: false)
        .getBestSellingProducts(
      productType: widget.productTypeString,
      offset: 1,
      reload: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder: (context, prodProvider, child) {
        List<Product>? productList = widget.productTypeString == 'store'
            ? prodProvider.bestSellingStoreProducts
            : prodProvider.bestSellingRestaurantProducts;
        bool isLoading = prodProvider.filterFirstLoading;

        // Limit to 10 products on home page
        if (widget.isHomePage && (productList?.length ?? 0) > 10) {
          productList = productList?.sublist(0, 10);
        }

        return isLoading || (productList?.isEmpty ?? false)
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: widget.scrollController,
                child: Row(
                  children: List.generate(
                    10, // Show 10 shimmer placeholders to match max products
                    (index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: SizedBox(
                        width: 150, // Match ProductWidget width
                        child: ProductShimmerWidget(
                          isHomePage: true,
                          isEnabled: true,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: widget.scrollController,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: productList!
                      .asMap()
                      .entries
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: SizedBox(
                            width: 150, // Consistent width
                            child: ProductWidget(productModel: entry.value),
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
      },
    );
  }
}

class ProductShimmerWidget extends StatelessWidget {
  final bool isHomePage;
  final bool isEnabled;

  const ProductShimmerWidget({
    super.key,
    required this.isHomePage,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLtr =
        Provider.of<LocalizationController>(context, listen: false).isLtr;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: isEnabled,
      child: Container(
        margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          border: Border.all(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.10),
            width: 1,
          ),
          color: Theme.of(context).highlightColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(9, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Placeholder
                LayoutBuilder(
                  builder: (context, boxConstraint) => Container(
                    margin: const EdgeInsets.only(
                      left: Dimensions.paddingSizeSmall,
                      top: Dimensions.paddingSizeSmall,
                      right: Dimensions.paddingSizeSmall,
                    ),
                    height: boxConstraint.maxWidth * 0.82,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(Dimensions.paddingSizeEight),
                      border: Border.all(
                        color: Theme.of(context)
                            .primaryColor
                            .withValues(alpha: 0.10),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                // Details Placeholder
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      // Rating Placeholder
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 2),
                          Container(
                            width: 40,
                            height: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      // Name Placeholder
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: Dimensions.paddingSizeSmall,
                        ),
                        child: Container(
                          width: 100,
                          height: 16,
                          color: Colors.white,
                        ),
                      ),
                      // Original Price Placeholder (strikethrough)
                      Container(
                        width: 60,
                        height: 12,
                        color: Colors.white,
                      ),
                      // Discounted Price Placeholder
                      const SizedBox(height: 2),
                      Container(
                        width: 80,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    ],
                  ),
                ),
              ],
            ),
            // Discount Tag Placeholder
            Positioned(
              top: 0,
              left: isLtr ? 0 : null,
              right: isLtr ? null : 0,
              child: Container(
                width: 40,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: isLtr
                        ? const Radius.circular(Dimensions.paddingSizeSmall)
                        : Radius.zero,
                    bottomLeft: isLtr
                        ? Radius.zero
                        : const Radius.circular(Dimensions.paddingSizeSmall),
                  ),
                ),
              ),
            ),
            // Favorite Button Placeholder
            Positioned(
              top: 18,
              right: isLtr ? 16 : null,
              left: isLtr ? null : 16,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: ColorResources.getImageBg(context),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
