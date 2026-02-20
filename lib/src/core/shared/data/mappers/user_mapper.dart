import 'package:test_multiplier_app/src/core/core.dart';

abstract class UserMapper {
  static UserEntity toEntity(UserModel model) {
    return UserEntity(email: model.email, id: model.id, name: model.name);
  }
}
