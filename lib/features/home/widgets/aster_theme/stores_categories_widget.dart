import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/title_row_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/aster_theme/categories_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/aster_theme/stores_categories_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/screens/view_all_product_category_screen.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class StoreCategoryListWidget extends StatelessWidget {
  const StoreCategoryListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final productController =
        Provider.of<ProductController>(context, listen: false);
    return Consumer<CategoryController>(
        builder: (context, categoryController, _) {
      return categoryController.storeCategoryList.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraExtraSmall),
                  child: TitleRowWidget(
                    title: getTranslated('store_categories', context),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const StoreCategoryListScreen()));
                    },
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: MasonryGridView.count(
                    itemCount:
                        categoryController.storeCategoryList.length - 1 > 4
                            ? 4
                            : categoryController.storeCategoryList.length - 1,
                    crossAxisCount: ResponsiveHelper.isDesktop(context)
                        ? 4
                        : ResponsiveHelper.isTab(context)
                            ? 3
                            : 2,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // productController.getProductsByCategoryList(true,
                          //     idCategory: categoryController
                          //         .storeCategoryList[index + 1].id
                          //         .toString());
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AllProductCategoryScreen(
                                    idCategory: categoryController
                                        .storeCategoryList[index + 1].id
                                        .toString(),
                                    title: categoryController
                                        .storeCategoryList[index + 1].name,
                                  )));
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.2),
                              width: 0.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 0.5,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    categoryController
                                            .storeCategoryList[index + 1]
                                            .iconFullUrl
                                            .path ??
                                        '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Icon(
                                      Icons.fastfood,
                                      color: theme.primaryColor,
                                      size: 18, // Smaller icon
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8), // Reduced spacing

                              // Compact text section
                              Expanded(
                                child: Text(
                                  categoryController
                                      .storeCategoryList[index + 1].name,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.grey[800],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              Icon(
                                Icons.chevron_right,
                                color: Colors.grey.withOpacity(0.6),
                                size: 16, // Smaller icon
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : const CategoryShimmer();
    });
  }
}
