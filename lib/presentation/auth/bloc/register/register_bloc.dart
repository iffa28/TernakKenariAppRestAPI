
import 'package:canaryfarm_app/data/models/request/auth/register_request_model.dart';
import 'package:canaryfarm_app/data/repository/auth_repository.dart';
import 'package:canaryfarm_app/presentation/auth/bloc/register/register_event.dart';
import 'package:canaryfarm_app/presentation/auth/bloc/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';



class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  RegisterBloc({required this.authRepository}) : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
    // TODO: implement event handler
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    final result = await authRepository.register(event.requestModel);

    result.fold(
      (l) => emit(RegisterFailure(error: l)),
      (r) => emit(RegisterSuccess(message: r)),
    );
  }
}
