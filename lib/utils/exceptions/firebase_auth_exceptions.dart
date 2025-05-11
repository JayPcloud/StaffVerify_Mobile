import '../constants/texts.dart';

class VFirebaseAuthException  implements Exception{

  final String code;

  VFirebaseAuthException({required this.code});

  String get message {
    switch(code) {
      case 'email-already-in-use':
        return 'The provided email address is already in use. Please use a different email';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email';
      case 'operation-not-allowed':
        return 'Operation not allowed. ${VTexts.requestSupportErrMsg}';
      case 'weak-password':
        return 'Weak password. Please provide a strong password \n Hint: minimum of 6 alphanumeric characters';
      case 'wrong-password':
        return 'Wrong password. Please provide a valid password or click on "forgot password"';
      case 'user-disabled':
        return 'This account has been disabled. ${VTexts.requestSupportErrMsg}';
      case 'user-not-found':
        return 'User not found. Please provide a valid login details';
      case 'network-request-failed':
        return 'Network error!\nPlease make sure you are connected to the internet';
      case 'email-already-exists':
        return 'The provided email address is already in use. Please use a different email';
      case 'too-many-requests':
        return 'Too many requests! ${VTexts.retryErrMsg} or contact support for assistance';
      case 'invalid-credential':
        return 'Invalid Credential!\nPlease make sure the provided login details are correct';
      default:
        return VTexts.defaultErrorMessage;
    }
  }

}