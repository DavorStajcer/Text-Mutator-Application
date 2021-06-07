import '../../../core/constants/error_messages.dart';
import '../domain/user_data_validator.dart';

class UserDataValidatorImpl extends UserDataValidator {
  @override
  String? validateUsername(String text) {
    if (text.length > 10)
      return INPUT_USERNAME_LONG;
    else if (text.length < 3) return INPUT_USERNAME_SHORT;
    return null;
  }
}
