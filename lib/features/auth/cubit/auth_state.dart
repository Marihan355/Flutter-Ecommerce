abstract class AuthState {} //can't create an object of abstract class directly, only thr subclasses.

//initial
class AuthInitial extends AuthState {} 

//leading (like ui updates of a spinner after user clickes login or register)
class AuthLoading extends AuthState {}

// sucess loginor register
class AuthSuccess extends AuthState {
  final String uid; 
  AuthSuccess(this.uid); //user's firebase id
}

//failure
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

//logging out
class AuthLoggedOut extends AuthState {}