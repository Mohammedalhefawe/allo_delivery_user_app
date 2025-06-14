import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/enums/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/widgets/products_list_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

class TopProductListScreen extends StatefulWidget {
  final ScrollController scrollController;

  const TopProductListScreen({super.key, required this.scrollController});

  @override
  State<TopProductListScreen> createState() => _TopProductListScreenState();
}

class _TopProductListScreenState extends State<TopProductListScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '${getTranslated('top_product', context)}',
      ),
      body: Consumer<ProductController>(
        builder: (context, productController, child) {
          if (productController.discountedProductModel == null) {
            return const ProductShimmer(isEnabled: true, isHomePage: false);
          }

          return (productController.latestProductList?.isNotEmpty ?? false)
              ? SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault)
                        .copyWith(bottom: Dimensions.paddingSizeSmall),
                    child: ProductListWidget(
                        isHomePage: false,
                        productType: ProductType.bestSelling,
                        scrollController: scrollController),
                  ),
                )
              : const Center(
                  child: NoInternetOrDataScreenWidget(
                  isNoInternet: false,
                  message: 'currently_no_product_available',
                  icon: Images.noOffer,
                ));
        },
      ),
    );
  }
}
