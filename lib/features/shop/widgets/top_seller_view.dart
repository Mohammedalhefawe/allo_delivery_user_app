import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/paginated_list_view_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/aster_theme/categories.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/seller_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/seller_card.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class TopSellerView extends StatefulWidget {
  final bool isHomePage;
  final ScrollController scrollController;
  final String title;
  const TopSellerView(
      {super.key,
      required this.isHomePage,
      required this.scrollController,
      required this.title});

  @override
  State<TopSellerView> createState() => _TopSellerViewState();
}

class _TopSellerViewState extends State<TopSellerView> {
  @override
  Widget build(BuildContext context) {
    final categoryController =
        Provider.of<CategoryController>(context, listen: false);
    return Consumer<ShopController>(
      builder: (context, topSellerProvider, child) {
        return (topSellerProvider.sellerModel != null &&
                topSellerProvider.sellerModel!.sellers != null &&
                topSellerProvider.sellerModel!.sellers!.isNotEmpty &&
                (widget.title == 'store' &&
                        categoryController.storeCategoryList.isNotEmpty ||
                    widget.title == 'restaurant' &&
                        categoryController.restaurantCategoryList.isNotEmpty))
            ? Column(
                mainAxisSize: MainAxisSize.min, // Add this
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeExtraExtraSmall,
                    ),
                    child: Consumer<CategoryController>(
                        builder: (context, categoryController, _) {
                      return NewCategoriesWidget(
                        selectedCategory: widget.title == 'store'
                            ? categoryController.storeCategorySelectedIndex ?? 1
                            : categoryController
                                    .restaurantCategorySelectedIndex ??
                                1,
                        categories: widget.title == 'store'
                            ? categoryController.storeCategoryList
                            : categoryController.restaurantCategoryList,
                        press: (id) {
                          if (widget.title == 'store') {
                            categoryController.changeSelectedStoreIndex(id);
                          } else {
                            categoryController
                                .changeSelectedRestaurantIndex(id);
                          }
                          topSellerProvider.setSellerType(
                              topSellerProvider.sellerType,
                              id == 0 ? widget.title : null,
                              id.toString());
                        },
                      );
                    }),
                  ),
                  // Replace Expanded with Flexible or remove it
                  Flexible(
                    fit: FlexFit.loose, // Allow child to size naturally
                    child: SingleChildScrollView(
                      controller: widget.scrollController,
                      child: PaginatedListView(
                        scrollController: widget.scrollController,
                        onPaginate: (int? offset) async =>
                            await topSellerProvider.getTopSellerList(
                                false, offset ?? 1,
                                type: topSellerProvider.sellerType,
                                category: topSellerProvider.categoryTitle),
                        totalSize: topSellerProvider.sellerModel!.totalSize,
                        offset: topSellerProvider.sellerModel!.offset,
                        itemView: ListView.builder(
                          itemCount:
                              topSellerProvider.sellerModel?.sellers?.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: widget.isHomePage
                              ? Axis.horizontal
                              : Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return SellerCard(
                                sellerModel: topSellerProvider
                                    .sellerModel?.sellers?[index],
                                isHomePage: widget.isHomePage,
                                index: index,
                                length: topSellerProvider
                                        .sellerModel?.sellers?.length ??
                                    0);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SellerShimmer();
      },
    );
  }
}
/*



import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/paginated_list_view_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/seller_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/top_seller_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/seller_card.dart';
import 'package:provider/provider.dart';

class TopSellerView extends StatefulWidget {
  final bool isHomePage;
  final ScrollController scrollController;
  const TopSellerView(
      {super.key, required this.isHomePage, required this.scrollController});

  @override
  State<TopSellerView> createState() => _TopSellerViewState();
}

class _TopSellerViewState extends State<TopSellerView> {
  @override
  Widget build(BuildContext context) {
    return widget.isHomePage
        ? Consumer<ShopController>(
            builder: (context, topSellerProvider, child) {
              return topSellerProvider.sellerModel != null
                  ? (topSellerProvider.sellerModel!.sellers != null &&
                          topSellerProvider.sellerModel!.sellers!.isNotEmpty)
                      ? ListView.builder(
                          itemCount:
                              topSellerProvider.sellerModel?.sellers?.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: widget.isHomePage
                              ? Axis.horizontal
                              : Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                                width: 250,
                                child: SellerCard(
                                    sellerModel: topSellerProvider
                                        .sellerModel?.sellers?[index],
                                    isHomePage: widget.isHomePage,
                                    index: index,
                                    length: topSellerProvider
                                            .sellerModel?.sellers?.length ??
                                        0));
                          },
                        )
                      : const SizedBox()
                  : const TopSellerShimmer();
            },
          )
        : Consumer<ShopController>(
            builder: (context, topSellerProvider, child) {
              return topSellerProvider.sellerModel != null
                  ? (topSellerProvider.sellerModel!.sellers != null &&
                          topSellerProvider.sellerModel!.sellers!.isNotEmpty)
                      ? SingleChildScrollView(
                          controller: widget.scrollController,
                          child: PaginatedListView(
                            scrollController: widget.scrollController,
                            onPaginate: (int? offset) async =>
                                await topSellerProvider.getTopSellerList(
                                    false, offset ?? 1,
                                    type: topSellerProvider.sellerType,
                                    category: topSellerProvider.categoryTitle),
                            totalSize: topSellerProvider.sellerModel!.totalSize,
                            offset: topSellerProvider.sellerModel!.offset,
                            itemView: ListView.builder(
                              itemCount: topSellerProvider
                                  .sellerModel?.sellers?.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              scrollDirection: widget.isHomePage
                                  ? Axis.horizontal
                                  : Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return SellerCard(
                                    sellerModel: topSellerProvider
                                        .sellerModel?.sellers?[index],
                                    isHomePage: widget.isHomePage,
                                    index: index,
                                    length: topSellerProvider
                                            .sellerModel?.sellers?.length ??
                                        0);
                              },
                            ),
                          ),
                        )
                      : const SizedBox()
                  : const SellerShimmer();
            },
          );
  }
}






 */
