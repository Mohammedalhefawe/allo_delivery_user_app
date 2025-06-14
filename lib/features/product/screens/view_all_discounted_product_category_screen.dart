import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class DiscountedProductsScreen extends StatefulWidget {
  final String productType;
  final int discount;
  final String title;
  const DiscountedProductsScreen({
    super.key,
    required this.productType,
    required this.discount,
    required this.title,
  });

  @override
  State<DiscountedProductsScreen> createState() =>
      _DiscountedProductsScreenState();
}

class _DiscountedProductsScreenState extends State<DiscountedProductsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch initial products
    Provider.of<ProductController>(context, listen: false)
        .getDiscountedProducts(
      productType: widget.productType,
      discount: widget.discount,
      offset: 1,
      reload: true,
    );

    // Add scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.position.pixels &&
          !Provider.of<ProductController>(context, listen: false)
              .filterIsLoading &&
          Provider.of<ProductController>(context, listen: false)
              .discountedProductList
              .isNotEmpty &&
          Provider.of<ProductController>(context, listen: false)
                      .discountedOffset *
                  10 <
              (Provider.of<ProductController>(context, listen: false)
                      .discountedPageSize ??
                  0)) {
        int newOffset = Provider.of<ProductController>(context, listen: false)
                .discountedOffset +
            1;
        Provider.of<ProductController>(context, listen: false)
            .showBottomLoader();
        Provider.of<ProductController>(context, listen: false)
            .getDiscountedProducts(
          productType: widget.productType,
          discount: widget.discount,
          offset: newOffset,
          reload: false,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title:
            '${getTranslated('discounted_products', context)} ${widget.title}',
      ),
      body: Consumer<ProductController>(
        builder: (context, prodProvider, child) {
          List<Product>? productList = prodProvider.discountedProductList;

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Column(
                    children: [
                      !prodProvider.filterFirstLoading
                          ? (productList.isNotEmpty)
                              ? RepaintBoundary(
                                  child: MasonryGridView.count(
                                    itemCount: productList.length,
                                    crossAxisCount:
                                        ResponsiveHelper.isTab(context) ? 3 : 2,
                                    padding: const EdgeInsets.all(0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ProductWidget(
                                          productModel: productList[index]);
                                    },
                                  ),
                                )
                              : const NoInternetOrDataScreenWidget(
                                  isNoInternet: false)
                          : ProductShimmer(
                              isHomePage: false,
                              isEnabled: prodProvider.filterFirstLoading,
                            ),
                      prodProvider.filterIsLoading
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.iconSizeExtraSmall),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
