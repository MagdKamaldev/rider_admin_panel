class ApiConstants {
  static const String serverIp = "localhost";
  static const String baseUrl = 'http://$serverIp:3006/api/';
  static const String login = 'login';//done
  //manager
  static const String register = 'admin/register';//Done
  static const String fetchManagers = 'admin/FetchManagers';//Done
  static const String updateManager = 'admin/EditUser';
  static const String deleteManager = 'admin/DeleteManager';//Done
  //branch
  static const String fetchBranchData = "admin/FetchDataRequiredForBranch";//Done
  static const String addBranch = "admin/AddShopBranch";//Done
  static const String fetchBranches = "admin/FetchShopBranches";//Done
  static const String editBranch = "admin/EditShopBranch";
  static const String deleteBranch = "admin/DeleteShopBranch";//Done
  //franchise
  static const String fetchFranchises = "admin/FetchFranchises";//Done
  static const String addFranchise = "admin/AddFranchise";//Done
  static const String editFranchise = "admin/EditFranchise";
  static const String deleteFranchise = "admin/DeleteFranchise";//Done
  //hub
  static const String fetchHubs = "admin/FetchHubs";//Done
  static const String addHub = "admin/AddHub";//Done
  static const String fetchHub = "admin/FetchHubByID";//Done
  static const String editHub = "admin/EditHub";
  static const String deleteHub = "admin/DeleteHub";//Done
}


