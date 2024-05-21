class AuthStates {}

class AuthInitialState extends AuthStates {}

// SignIn states
class LoginLoadingState extends AuthStates {} 
// cache model --> token ==api normal database
//firebase auth موفره دا
class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  final String error;
  LoginErrorState({required this.error});
} 

// Register states
class RegisterLoadingState extends AuthStates {}    

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  final String error;
  RegisterErrorState({ required this.error});
}
//////////////////////////////////////////////////////
 
class UpdateDoctorLoadingState extends AuthStates {}
class UpdateDoctorSuccessState extends AuthStates {}
class UpdateDoctorErrorState extends AuthStates {
  final String error;

  UpdateDoctorErrorState({required this.error});

}