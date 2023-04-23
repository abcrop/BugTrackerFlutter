import '../../constants/app_constants.dart';
import '../../utils/helpers/app_helpers.dart';

class User {
  User({this.id, this.fullName, this.userName, this.password, this.email, this.role, this.image, this.userType, this.dateCreated});

  final String? id;
  final String? fullName;
  final String? userName;
  final String? password;
  final String? email;
  final String? role;
  final String? image;
  final UserType? userType;
  final int? dateCreated;

  Map<String, dynamic> toMap() {
    return {
      SpringBootKeys.id: id,
      SpringBootKeys.fullName: fullName,
      SpringBootKeys.userName: userName,
      SpringBootKeys.password: password,
      SpringBootKeys.email: email,
      SpringBootKeys.role: role,
      SpringBootKeys.image: image,
      SpringBootKeys.userType: userType,
      SpringBootKeys.dateCreated: getCurrentTimeInMilliseconds(),
    };
  }

  factory User.fromMap(Map<dynamic, dynamic> map) {
    logger.d(map.values);
    return User(
        id: map.containsKey(SpringBootKeys.id)
            ? map[SpringBootKeys.id] as String
            : "",
        fullName: map.containsKey(SpringBootKeys.fullName)
            ? map[SpringBootKeys.fullName] as String
            : "",
        userName: map.containsKey(SpringBootKeys.userName)
            ? map[SpringBootKeys.userName] as String
            : "",
        password: map.containsKey(SpringBootKeys.password)
            ? map[SpringBootKeys.password] as String
            : "",
        email: map.containsKey(SpringBootKeys.email)
            ? map[SpringBootKeys.email] as String
            : "",
        role: map.containsKey(SpringBootKeys.role)
            ? map[SpringBootKeys.role] as String
            : "",
        image: map.containsKey(SpringBootKeys.image)
            ? map[SpringBootKeys.image] as String
            : "",
        userType: map.containsKey(SpringBootKeys.userType)
            ? stringToUserType(map[SpringBootKeys.userType])
            : UserType.tester,
        dateCreated: map.containsKey(SpringBootKeys.dateCreated)
            ? map[SpringBootKeys.dateCreated] as int
            : 0);
  }
}
