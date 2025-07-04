import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/search_shops_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/top_seller_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

class AllTopSellerScreen extends StatefulWidget {
  final String title;
  const AllTopSellerScreen({super.key, required this.title});

  @override
  State<AllTopSellerScreen> createState() => _AllTopSellerScreenState();
}

class _AllTopSellerScreenState extends State<AllTopSellerScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ShopController>(builder: (context, shopController, _) {
      return Scaffold(
          backgroundColor: ColorResources.getIconBg(context),
          appBar: CustomAppBar(
            title: '${getTranslated(widget.title, context)}',
            // title: ,
            showResetIcon: true,
            reset:
                Consumer<ShopController>(builder: (context, shopController, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeLarge),
                child: Row(
                  children: [
                    IconButton(
                      tooltip: 'search',
                      onPressed: () {
                        final categoryController =
                            Provider.of<CategoryController>(context,
                                listen: false);
                        String? idCategory;
                        String? category;
                        if (widget.title == 'store') {
                          idCategory = categoryController
                              .storeCategorySelectedIndex
                              .toString();
                          category = 'store';
                        } else {
                          idCategory = categoryController
                              .restaurantCategorySelectedIndex
                              .toString();
                          category = 'restaurant';
                        }
                        shopController.searchModel = null;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SearchShopsScreen(
                              title: widget.title,
                              sellerType: shopController.sellerType,
                              category: category,
                              categoryId: idCategory,
                            ),
                          ),
                        );
                      },
                      color: Theme.of(context).iconTheme.color,
                      icon: const Icon(Icons.search),
                    ),
                    PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                                value: "new",
                                textStyle: textRegular.copyWith(
                                    color: Theme.of(context).hintColor),
                                child: Text(
                                    getTranslated('new_seller', context) ??
                                        '')),
                            PopupMenuItem(
                                value: "all",
                                textStyle: textRegular.copyWith(
                                    color: Theme.of(context).hintColor),
                                child: Text(
                                    getTranslated('all_seller', context) ??
                                        '')),
                            PopupMenuItem(
                                value: "top",
                                textStyle: textRegular.copyWith(
                                    color: Theme.of(context).hintColor),
                                child: Text(
                                    getTranslated('top_seller', context) ??
                                        '')),
                          ];
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeSmall)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                Dimensions.paddingSizeExtraSmall,
                                Dimensions.paddingSizeSmall,
                                Dimensions.paddingSizeExtraSmall,
                                Dimensions.paddingSizeSmall),
                            child: Image.asset(Images.dropdown, scale: 3)),
                        onSelected: (dynamic value) {
                          final categoryController =
                              Provider.of<CategoryController>(context,
                                  listen: false);
                          String? idCategory;
                          if (widget.title == 'store') {
                            idCategory = categoryController
                                .storeCategorySelectedIndex
                                .toString();
                          } else {
                            idCategory = categoryController
                                .restaurantCategorySelectedIndex
                                .toString();
                          }
                          shopController.setSellerType(
                              value,
                              idCategory == '0' ? widget.title : null,
                              idCategory,
                              notify: true);
                        }),
                  ],
                ),
              );
            }),
          ),
          body: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: TopSellerView(
                title: widget.title,
                isHomePage: false,
                scrollController: scrollController,
              )));
    });
  }
}
