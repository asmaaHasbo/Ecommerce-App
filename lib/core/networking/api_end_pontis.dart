class ApiEndPontis {
  static const String baseUrl = 'https://ecommerce.routemisr.com/api/v1/';
  
  static const String signUp = 'auth/signup';
  
  static const String login = 'auth/signin';
  
  static const String forgotPassword = 'auth/forgotPasswords';
  
  static const String verifyResetCode = 'auth/verifyResetCode';
  
  static const String resetPassword = 'auth/resetPassword';
  
  static const String categories = 'categories';
  
  static const String products = 'products';
  
  static const String addProductToCart = 'cart/items';
  
  static const String getCartProduct = 'cart';
  
  static const String deleteProduct = 'cart/items/{id}';
  
  static const String wishlist = 'wishlist';
}
