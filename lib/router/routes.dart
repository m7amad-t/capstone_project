class AppRoutes {


  // ------------- shell routes ------------------------
  static String main = "/";
  static String login = "/login";
  static String home = "/home";
  static String saleAnalytics = "/sale_analytics";
  static String cart= "/cart";
  static String productManagement = "/product_management";
  static String expensesTracking = "/expenses_tracking";
  static String settings = "/settings";  // it might remove
  static String profile = "/prfile";     // it might remove

  // static String saleTracking= "/sale_tracking";  \\ replaced with home 

  // ---------------- child routes ----------------------

  // -------- [[ sale (main) childs ]]
  static String saleHistory= "sale_history";
  static String returnProductFromInvoice= "return_product_from_invoice";


  // --------------------- [[ Product management childs ]] ---------------------
  static String product = "product";     
  static String category = "category";   
  static String buyProducts = "buy_products";   
  static String buyProductsFrom = "buying_form";   
  static String boughtedProducts = "boughted";  
  static String returnedProduct = "returned_products";   
  static String returnedProductsHistory = "returned_products_history";   
  static String returnProductFrom = "return_product_form";   
  static String addProduct = "add_product";     
  static String productDetail = "product_detail";     
  static String editProduct = "edit_product"; 
  static String editCategory = "edit_category"; 
  static String addCategory = "add_category";     
  static String damagedProducts = "damaged_products";     
  static String damagedProductsHistory = "damaged_products_history";     
  static String damagedProductForm = "damaged_product_form";      
  static String expiredProducts = "expired_products";     

  // ---------------------- [[ cart childs ]] -------------------------------
  static String cartCheckout= "checkout";

  
  // ---------------------- [[ expenses childs ]] -------------------------------
  static String addExpensesType= "add_expenses_type";
  static String addExpesnesRecord= "add_expenses_record";
  static String expensRecordHistory= "expens_record_history";



  // ---------------------- [[ profile childs ]] -------------------------------
  static String addUser= "add_user";



}