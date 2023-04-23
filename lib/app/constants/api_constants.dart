
part of app_constants;

class ApiConstants {

  //Base
  static const String baseURL = "http://localhost:8082/api/v1";

  //Home
  static const String getHomeData = baseURL + "/getHomeData";

  //User
  static const String createUser = baseURL + "/createUser";
  static const String getAllUsers = baseURL + "/getAllUsers";
  static const String updateUser = baseURL + "/updateUser";
  static const String getUser = baseURL + "/getUser";
  static const String deleteUser = baseURL + "/deleteUser";

  //Project
  static const String createProject = baseURL + "/createProject";
  static const String getAllProjects = baseURL + "/getAllProjects";
  static const String getAllProjectDataResponse = baseURL + "/getAllProjectDataResponse";
  static const String updateProject = baseURL + "/updateProject";
  static const String getProject = baseURL + "/getProject";
  static const String deleteProject = baseURL + "/deleteProject";

  //Project
  static const String createBug = baseURL + "/createBug";
  static const String getAllBugs = baseURL + "/getAllBugs";
  static const String updateBug = baseURL + "/updateBug";
  static const String getBug = baseURL + "/getBug";
  static const String deleteBug = baseURL + "/deleteBug";

  //Activity
  static const String createActivity = baseURL + "/createActivity";
  static const String getAllActivities = baseURL + "/getAllActivities";
  static const String updateActivity = baseURL + "/updateActivity";
  static const String getActivity = baseURL + "/getActivity";
  static const String deleteActivity = baseURL + "/deleteActivity";







}
