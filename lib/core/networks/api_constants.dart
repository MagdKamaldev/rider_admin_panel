class ApiConstants {
  static const String serverIp = "localhost";
  static const String baseUrl = 'http://$serverIp:3006/api/';
  static const String login = 'login';
  //manager
  static const String register = 'admin/register';
  static const String fetchManagers = 'admin/FetchManagers';
  static const String updateManager = 'admin/EditUser';
  static const String deleteManager = 'admin/DeleteManager';
  //branch
  static const String fetchBranchData = "admin/FetchDataRequiredForBranch";
  static const String addBranch = "admin/AddShopBranch";
  static const String fetchBranches = "admin/FetchShopBranches";
  static const String editBranch = "admin/EditShopBranch";
  static const String deleteBranch = "admin/DeleteShopBranch";
  //franchise
  static const String fetchFranchises = "admin/FetchFranchises";
  static const String addFranchise = "admin/AddFranchise";
  static const String editFranchise = "admin/EditFranchise";
  static const String deleteFranchise = "admin/DeleteFranchise";
  //hub
  static const String fetchHubs = "admin/FetchHubs";
  static const String addHub = "admin/AddHub";
  static const String fetchHub = "admin/FetchHubByID";
  static const String editHub = "admin/EditHub";
  static const String deleteHub = "admin/DeleteHub";
}


