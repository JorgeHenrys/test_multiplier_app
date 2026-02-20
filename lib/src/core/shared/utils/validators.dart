String? requiredFieldValidator(String? value, String errorMessage) {
  if (value == null || value.isEmpty) {
    return errorMessage;
  }
  return null;
}

String? emailValidator(String? value, String errorMessage) {
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  if (value != null) {
    if (emailRegex.hasMatch(value)) return null;
  }
  return errorMessage;
}

String? comparePasswords(
  String? password,
  String? confirmedPassword,
  String errorMessage,
) {
  if (password == confirmedPassword) {
    return null;
  }
  return errorMessage;
}
