class ApiServices {
  static String baseUrl = "https://fakestoreapi.com";
  static String categoryUrl = "$baseUrl/products/categories";
  static String limitproductUrl = "$baseUrl/products?limit=8";
  
   static String productDescription(int productId) {
    return "$baseUrl/products/$productId"; 
  }
  
  static String searchUrl="$baseUrl/products?sort=desc";
}
