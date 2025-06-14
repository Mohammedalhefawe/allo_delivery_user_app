import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/title_row_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/screens/category_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/aster_theme/section_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/aster_theme/section_widget_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

import '../../../category/controllers/category_controller.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
        builder: (context, categoryProvider, child) {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeExtraExtraSmall),
          child: TitleRowWidget(
            title: getTranslated('CATEGORY', context),
            onTap: () {
              if (categoryProvider.categoryList.isNotEmpty) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CategoryScreen()));
              }
            },
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        SizedBox(
          height: ResponsiveHelper.isTab(context) ? 165 : 150,
          child: categoryProvider.categoryList.isEmpty
              ? const ShimmerSectionWidget()
              : SectionWidget(categoryProvider: categoryProvider),
        ),
      ]);
    });
  }
}
