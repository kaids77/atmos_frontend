/// Maps Firebase/backend error codes to user-friendly messages.
String friendlyAuthError(String? rawError) {
  if (rawError == null || rawError.isEmpty) return 'Something went wrong. Please try again.';

  final code = rawError.toUpperCase();

  // Sign-in errors
  if (code.contains('INVALID_LOGIN_CREDENTIALS') ||
      code.contains('INVALID_PASSWORD') ||
      code.contains('EMAIL_NOT_FOUND') ||
      code.contains('USER_NOT_FOUND')) {
    return 'No account found with this email, or the password is incorrect.';
  }
  if (code.contains('USER_DISABLED')) {
    return 'This account has been disabled. Please contact support.';
  }
  if (code.contains('TOO_MANY_ATTEMPTS') || code.contains('TOO_MANY_REQUESTS')) {
    return 'Too many failed attempts. Please wait and try again.';
  }

  // Sign-up errors
  if (code.contains('EMAIL_EXISTS')) {
    return 'An account with this email already exists.';
  }
  if (code.contains('WEAK_PASSWORD')) {
    return 'Password is too weak. Please use at least 8 characters.';
  }
  if (code.contains('INVALID_EMAIL')) {
    return 'Please enter a valid email address.';
  }

  // Network / server errors
  if (code.contains('FIREBASE CONNECTION ERROR') || code.contains('NETWORK')) {
    return 'Could not connect to the server. Check your internet connection.';
  }

  // Fallback: return a cleaned-up version of the raw message
  return rawError;
}
