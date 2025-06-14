import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/screens/brand_and_category_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class SectionWidget extends StatelessWidget {
  final CategoryController categoryProvider;
  const SectionWidget({super.key, required this.categoryProvider});

  static const List<SectionItem> items = [
    SectionItem(title: 'stores', subtitle: 'New arrivals', icon: Icons.store),
    SectionItem(
        title: 'restaurants', subtitle: '50+ places', icon: Icons.restaurant),
    SectionItem(
        title: 'order_now',
        subtitle: 'Fast delivery',
        icon: Icons.delivery_dining),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
        builder: (context, categoryProvider, child) {
      return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraSmall),
        height: 120,
        child: LayoutBuilder(
          builder: (context, constraints) {
            const itemCount = 3;
            final availableWidth = constraints.maxWidth;
            final itemWidth = availableWidth / 3;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: itemWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: index == 2
                        ? CategoryCard(
                            item: items[index],
                            categoryProvider: null,
                            index: index,
                          )
                        : CategoryCard(
                            item: items[index],
                            categoryProvider: categoryProvider,
                            index: index,
                          ),
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }
}

class SectionItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const SectionItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class CategoryCard extends StatelessWidget {
  final SectionItem item;
  final CategoryController? categoryProvider;
  final int index;

  const CategoryCard({
    super.key,
    this.categoryProvider,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.paddingSizeExtraExtraSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        border: Border.all(
            color: Theme.of(context).primaryColor.withValues(alpha: .10),
            width: 1),
        color: Theme.of(context).highlightColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(9, 5),
          )
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (categoryProvider != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BrandAndCategoryProductScreen(
                        isBrand: false,
                        id: categoryProvider!.categoryList[index].id,
                        name: categoryProvider!.categoryList[index].name)));
          } else {
            //order now
            print("order now");
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 24,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                getTranslated(item.title, context)!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
