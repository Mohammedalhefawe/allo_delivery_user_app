import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/all_shop_screen.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../localization/language_constrants.dart';

class CategoryBannersWidget extends StatefulWidget {
  const CategoryBannersWidget({super.key});

  @override
  State<CategoryBannersWidget> createState() => _CategoryBannersWidgetState();
}

class _CategoryBannersWidgetState extends State<CategoryBannersWidget> {
  List<CategoryBannersModel> categories = [
    CategoryBannersModel(image: Images.storesImage, title: 'store'),
    CategoryBannersModel(image: Images.restaurantsImage, title: 'restaurant'),
    CategoryBannersModel(image: Images.orderNowImage, title: 'order_now'),
  ];

  int currentIndex = 0;

  void _showOrderNowDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  getTranslated('contact_us', context) ?? 'Contact Us',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  getTranslated('choose_contact_method', context) ??
                      'Choose your preferred contact method:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 20),
                // Audio Call Button
                _buildDialogButton(
                  context,
                  icon: Icons.phone,
                  label: getTranslated('audio_call', context) ?? 'Audio Call',
                  color: Colors.blue,
                  onPressed: () async {
                    final Uri phoneUri = Uri.parse('tel:+963996067560');
                    if (await canLaunchUrl(phoneUri)) {
                      await launchUrl(phoneUri);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                getTranslated('error_phone_call', context) ??
                                    'Could not launch phone call')),
                      );
                    }
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 12),
                // WhatsApp Chat Button
                _buildDialogButton(
                  context,
                  icon: FontAwesomeIcons.whatsapp,
                  label: getTranslated('whatsapp_chat', context) ??
                      'WhatsApp Chat',
                  color: Colors.green,
                  onPressed: () async {
                    final Uri whatsappUri =
                        Uri.parse('https://wa.me/+963996067560');
                    if (await canLaunchUrl(whatsappUri)) {
                      await launchUrl(whatsappUri);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                getTranslated('error_whatsapp', context) ??
                                    'Could not open WhatsApp')),
                      );
                    }
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 10),
                // Close Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      getTranslated('cancel', context) ?? "cancel",
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method to build styled buttons
  Widget _buildDialogButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double itemSize = width * 0.7;

    return Column(
      children: [
        SizedBox(
          height: itemSize,
          width: width,
          child: CarouselSlider.builder(
            itemCount: categories.length,
            options: CarouselOptions(
              aspectRatio: 1,
              viewportFraction: 0.7,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() => currentIndex = index);
              },
            ),
            itemBuilder: (context, index, _) {
              return InkWell(
                onTap: () {
                  if (categories[index].title == 'order_now') {
                    //order now code
                    _showOrderNowDialog(context);
                  } else {
                    final shopController =
                        Provider.of<ShopController>(context, listen: false);
                    final categoryController =
                        Provider.of<CategoryController>(context, listen: false);
                    String? idCategory;
                    if (categories[index].title == 'store') {
                      idCategory = categoryController.storeCategorySelectedIndex
                          .toString();
                    } else {
                      idCategory = categoryController
                          .restaurantCategorySelectedIndex
                          .toString();
                    }

                    shopController.setSellerType(
                        'all_seller',
                        idCategory == '0'
                            ? categories[index].title
                            : idCategory,
                        null);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AllTopSellerScreen(
                                  title: categories[index].title,
                                )));
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: Colors.grey[200],
                    child: Image.asset(
                      categories[index].image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryBannersModel {
  final String title;
  final String image;

  CategoryBannersModel({required this.title, required this.image});
}
