
import 'package:canaryfarm_app/data/models/response/burung_semua_tersedia_model.dart';
import 'package:canaryfarm_app/data/repository/get_all_burung_tersedia_repository.dart';
import 'package:canaryfarm_app/presentation/bloc/get_all_burung_tersedia/get_burung_tersedia_event.dart';
import 'package:canaryfarm_app/presentation/bloc/get_all_burung_tersedia/get_burung_tersedia_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


class GetBurungTersediaBloc
    extends Bloc<GetBurungTersediaEvent, GetBurungTersediaState> {
  final GetAllBurungTersediaRepository getAllBurungTersediaRepository;

  GetBurungTersediaBloc(this.getAllBurungTersediaRepository)
    : super(GetBurungTersediaInitial()) {
    on<GetAllBurungTersediaEvent>(_getAllBurungTersedia);
    // TODO: implement event handler
  }

  Future<void> _getAllBurungTersedia(
    GetAllBurungTersediaEvent event,
    Emitter<GetBurungTersediaState> emit,
  ) async {
    emit(GetBurungTersediaLoading());
    final result = await getAllBurungTersediaRepository.getAllBurungTersedia();
    result.fold(
      (error) => emit(GetBurungTersediaError(message: error)),
      (burungTersedia) =>
          emit(GetBurungTersediaLoaded(burungTersedia: burungTersedia)),
    );
  }
}
