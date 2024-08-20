class ApiConstants {
  static const String serverIp = "172.20.10.6";
  static const String baseUrl = 'http://$serverIp:3006/api/';
  static const String login = 'login';
  //User
  static const String registerUser = 'admin/register';
  static const String updateUser = 'admin/EditUser';
  //Manager
  static const String fetchManagers = 'admin/FetchManagers';
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
//Rider
static const String fetchRiders = "admin/FetchRiders";
static const String deleteRider = "admin/DeleteRider";
static const String editRiderHub = "admin/EditRiderHub";
static const String editRiderShiftTime = "admin/SetRiderShift" ;
//locations api 
// static const String searchPlace = "https://nominatim.openstreetmap.org/search?addressdetails=1&q=Gas%20near%20[30.0710632672488,%2031.348593242563744]&format=jsonv2&limit=5";
}
  

