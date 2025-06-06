import 'package:bloc/bloc.dart';
import 'package:canaryfarm_app/data/models/request/auth/login_request_model.dart';
import 'package:canaryfarm_app/data/models/response/auth_response_model.dart';
import 'package:canaryfarm_app/data/repository/auth_repository.dart';
import 'package:canaryfarm_app/presentation/auth/bloc/login/login_event.dart';
import 'package:canaryfarm_app/presentation/auth/bloc/login/login_state.dart';
import 'package:meta/meta.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
    // TODO: implement event handler
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState>emit
    ) async {
    emit(LoginLoading());

    final result = await authRepository.login(event.requestModel);

    result.fold(
      (l) => emit(LoginFailure(error: l)),
      (r) => emit(LoginSuccess(responseModel: r)),
    );
  }
}
