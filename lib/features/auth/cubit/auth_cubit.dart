import 'package:flutter_bloc/flutter_bloc.dart';  //the cubit is the cordinator, it combines repo(logic) with state(ui)
import '../repository/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo repo;

  AuthCubit(this.repo) : super(AuthInitial()); //cubit, here's your toolkit(repo) and startting point at initial state

//in login, pass the two parameter, and show in ui AuthLoading state
  Future<void> login(String email, String password) async { 
    try {
      emit(AuthLoading());
      final user = await repo.login(email, password);
      emit(AuthSuccess(user!.uid)); //success / ! means i'm sure user isn't null
    } catch (e) {
      emit(AuthFailure(e.toString())); //failure
    }
  }

//register
  Future<void> register(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await repo.register(email, password);
      emit(AuthSuccess(user!.uid));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

//logout signout()
  Future<void> logout() async {
    await repo.logout();
    emit(AuthLoggedOut());
  }
}