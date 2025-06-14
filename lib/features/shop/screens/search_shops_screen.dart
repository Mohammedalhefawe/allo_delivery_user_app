import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/paginated_list_view_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/seller_card.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/seller_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/top_seller_view.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:provider/provider.dart';

class SearchShopsScreen extends StatefulWidget {
  final String title;
  final String sellerType;
  final String? category;
  final String? categoryId;

  const SearchShopsScreen({
    super.key,
    required this.title,
    required this.sellerType,
    this.category,
    this.categoryId,
  });

  @override
  State<SearchShopsScreen> createState() => _SearchShopsScreenState();
}

class _SearchShopsScreenState extends State<SearchShopsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500)).then((_) {
        if (mounted) {
          FocusScope.of(context).requestFocus(_searchFocusNode);
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _searchFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      appBar: CustomAppBar(
        title: getTranslated('search_shops', context) ?? 'Search Shops',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: (Dimensions.paddingSizeSmall),
        ),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.paddingSizeSmall,
                right: Dimensions.paddingSizeSmall,
                top: Dimensions.paddingSizeSmall,
              ),
              child: Consumer<ShopController>(
                builder: (context, shopController, _) {
                  return SizedBox(
                    height: 56,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Hero(
                        tag: 'search',
                        child: Material(
                          child: TextFormField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            textInputAction: TextInputAction.search,
                            onFieldSubmitted: (value) {
                              if (value.trim().isNotEmpty) {
                                shopController.searchShops(
                                  type: 'all',
                                  category: widget.category,
                                  idCategory: null,
                                  query: value,
                                  offset: 1,
                                  reload: true,
                                );
                              } else {
                                showCustomSnackBar(
                                  getTranslated('enter_somethings', context),
                                  context,
                                );
                              }
                            },
                            style: textMedium.copyWith(
                                fontSize: Dimensions.fontSizeLarge),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeSmall),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.paddingSizeSmall),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.paddingSizeSmall),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.paddingSizeSmall),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              hintText:
                                  getTranslated('search_shops', context) ??
                                      'Search Shops',
                              suffixIcon: SizedBox(
                                width:
                                    _searchController.text.isNotEmpty ? 70 : 50,
                                child: Row(
                                  children: [
                                    if (_searchController.text.isNotEmpty)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _searchController.clear();
                                            shopController.searchModel = null;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.clear,
                                          size: 20,
                                        ),
                                      ),
                                    InkWell(
                                      onTap: () {
                                        if (_searchController.text
                                            .trim()
                                            .isNotEmpty) {
                                          _searchFocusNode.unfocus();
                                          shopController.searchShops(
                                            type: 'all',
                                            category: widget.category,
                                            idCategory: null,
                                            query: _searchController.text,
                                            offset: 1,
                                            reload: true,
                                          );
                                        } else {
                                          showCustomSnackBar(
                                            getTranslated(
                                                'enter_somethings', context),
                                            context,
                                          );
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          width: 40,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(Dimensions
                                                        .paddingSizeSmall)),
                                          ),
                                          child: SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  Dimensions.paddingSizeSmall),
                                              child: Image.asset(
                                                Images.search,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Shop Results
            Consumer<ShopController>(
              builder: (context, shopController, _) {
                return shopController.searchModel != null &&
                        shopController.searchModel!.totalSize != null &&
                        shopController.searchModel!.offset != null
                    ? Flexible(
                        fit: FlexFit.loose, // Allow child to size naturally
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: PaginatedListView(
                            scrollController: _scrollController,
                            onPaginate: (int? offset) async =>
                                await shopController.searchShops(
                              type: 'all',
                              category: widget.category,
                              idCategory: null,
                              query: _searchController.text,
                              offset: offset ?? 1,
                              reload: false,
                            ),
                            totalSize: shopController.searchModel!.totalSize,
                            offset: shopController.searchModel!.offset,
                            itemView: ListView.builder(
                              itemCount: (shopController
                                              .searchModel?.sellers?.length ??
                                          0) >
                                      1
                                  ? shopController
                                          .searchModel!.sellers!.length -
                                      1
                                  : 0,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return SellerCard(
                                    sellerModel: shopController
                                        .searchModel?.sellers?[index + 1],
                                    isHomePage: false,
                                    index: index + 1,
                                    length: shopController
                                            .searchModel?.sellers?.length ??
                                        0);
                              },
                            ),
                          ),
                        ),
                      )
                    : shopController.isSearchShop
                        ? const Expanded(child: SellerShimmer())
                        : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
