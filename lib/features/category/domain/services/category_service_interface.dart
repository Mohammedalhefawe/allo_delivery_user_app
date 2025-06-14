abstract class CategoryServiceInterface {
  Future<dynamic> getSellerWiseCategoryList(int sellerId);
  Future<dynamic> getList();
  Future<dynamic> getStoreCategoryList();
  Future<dynamic> getRestaurantCategoryList();
}
