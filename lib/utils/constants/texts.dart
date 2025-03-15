class VTexts {

  //App Details
  static const appName = 'StaffVerify';

  //Authentication
  static const login = "Login";
  static const signup = "SignUp ";
  static const email = "Email";
  static const password = "Password";
  static const username = "User Name";
  static const emailTextFieldHint = "e.g johndoe@gmail.com";
  static const usernameFieldHint = "e.g John Doe";
  static const resetPasswordInstruction = "Enter the email associated with your account and we will send an email with instructions "
  "to reset your password";
  static const successfulSignupMsg = "Account created successfully";

  //Error Texts
  static const defaultErrorMessage = "An error occurred!";
  static const retryErrMsg = "Please Try again later";
  static const imgUploadFailedErrMsg = "Couldn't upload Image. Please try again";

  //-----------fire_store_DB-----------------//
  //Users record
  static const usersCollection = "users";
  static const userIdField = "user_id";
  static const usernameField = "username";
  static const emailField = "email";
  static const emailVerified = "email_verified";
  static const userDisabledField = "user_disabled";
  static const verifierFieldValue = "verifier";
  static const adminFieldValue = "admin";

  //staff record
  static const staffCollection = "staff";
  static const staffIDField = "staff_Id";
  static const mobileNoField = "mobile_no";
  static const firstNameField = "first_name";
  static const lastNameField = "last_name";
  static const genderField = "gender";
  static const deptField = "department";
  static const roleField = "role";
  static const imageUrlField = "image_url";
  static const qrcodeField = "qrcode_data";

  static const totalStaffDocRef = "total_staff";

  //verification record
  static const verificationsCollection = "verifications";
  static const userVerificationHistoryCollection = "verification_history";
  static const idField = "id";
  static const vStatusField = "verification_status";
  static const vDateField = "verification_date";
  static const vMethodField = "verification_method";


  //Verification Methods
  static const qrCodeMethod = "qr_code";
  static const staffIdMethod = "staff_id";
  static const emailMethod = "email";
  static const mobileNoMethod = "mobile_no";


  //Get_Storage_Keys
  static const rememberMeKey = "Remember_Me";
  static const getStorageEmailKey = "Email_Remember_Me";
  static const getStoragePasswordKey = "Password_Remember_Me";

  //Image_Strings
  static const successVerificationIconPng = "assets/images/successful_verification_icon.png";
  static const failedVerificationIconPng = "assets/images/failed_verification_icon.png";

  //Icon Image Strings
  static const noPhotoIcon = "assets/icons/nophoto_icon.png";


  //-------------APIs-----------------//

  static const cloudinaryCloudName = "dx3ktwtgf";
  static const cloudinaryPresetName = "StaffVerify-Mobile";
  static const staffImageFolder = "staff_photo";
  static const qrcodeImageFolder = "staff_qrcode";

  //
}