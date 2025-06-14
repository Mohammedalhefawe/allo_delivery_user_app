import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/widgets/best_selling_products_list_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class BestSellingProductsScreen extends StatefulWidget {
  final String productType; // e.g., "store" or "restaurant"
  final String title;
  const BestSellingProductsScreen({
    super.key,
    required this.productType,
    required this.title,
  });

  @override
  State<BestSellingProductsScreen> createState() =>
      _BestSellingProductsScreenState();
}

class _BestSellingProductsScreenState extends State<BestSellingProductsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch initial best-selling products
    Provider.of<ProductController>(context, listen: false)
        .getBestSellingProducts(
      productType: widget.productType,
      offset: 1,
      reload: true,
    );

    // Add scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.position.pixels &&
          !Provider.of<ProductController>(context, listen: false)
              .filterIsLoading) {
        final prodProvider =
            Provider.of<ProductController>(context, listen: false);
        final productList = widget.productType == 'store'
            ? prodProvider.bestSellingStoreProducts
            : prodProvider.bestSellingRestaurantProducts;
        final pageSize = widget.productType == 'store'
            ? prodProvider.bestSellingStorePageSize
            : prodProvider.bestSellingRestaurantPageSize;
        final offset = widget.productType == 'store'
            ? prodProvider.bestSellingStoreOffset
            : prodProvider.bestSellingRestaurantOffset;

        if (productList != null &&
            productList.isNotEmpty &&
            offset * 10 < (pageSize ?? 0)) {
          int newOffset = offset + 1;
          prodProvider.showBottomLoader();
          prodProvider.getBestSellingProducts(
            productType: widget.productType,
            offset: newOffset,
            reload: false,
          );
        }
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
        title: widget.title,
      ),
      body: Consumer<ProductController>(
        builder: (context, prodProvider, child) {
          List<Product>? productList = widget.productType == 'store'
              ? prodProvider.bestSellingStoreProducts
              : prodProvider.bestSellingRestaurantProducts;
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Column(
                    children: [
                      !prodProvider.filterFirstLoading
                          ? (productList != null && productList.isNotEmpty)
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
                          : ProductShimmerWidget(
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
