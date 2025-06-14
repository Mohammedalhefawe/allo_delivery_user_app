import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/screens/offers_product_list_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/title_row_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class TopSellerProductListWidget extends StatelessWidget {
  const TopSellerProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(builder: (context, prodProvider, child) {
      return (prodProvider.discountedProductModel?.products != null &&
              prodProvider.discountedProductModel!.products!.isNotEmpty)
          ? Column(children: [
              TitleRowWidget(
                title: getTranslated('top_seller', context),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const OfferProductListScreen())),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall),
                child: Column(children: [
                  !prodProvider.filterFirstLoading
                      ? (prodProvider.discountedProductModel?.products !=
                                  null &&
                              prodProvider
                                  .discountedProductModel!.products!.isNotEmpty)
                          ? RepaintBoundary(
                              child: RepaintBoundary(
                                child: MasonryGridView.count(
                                  itemCount: prodProvider
                                      .discountedProductModel?.products?.length,
                                  crossAxisCount:
                                      ResponsiveHelper.isTab(context) ? 3 : 2,
                                  padding: const EdgeInsets.all(0),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProductWidget(
                                        productModel: prodProvider
                                            .discountedProductModel!
                                            .products![index]);
                                  },
                                ),
                              ),
                            )
                          : const NoInternetOrDataScreenWidget(
                              isNoInternet: false)
                      : ProductShimmer(
                          isHomePage: false,
                          isEnabled: prodProvider.firstLoading),
                  prodProvider.filterIsLoading
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.iconSizeExtraSmall),
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor)),
                        ))
                      : const SizedBox.shrink()
                ]),
              )
            ])
          : const SizedBox();
    });
  }
}
