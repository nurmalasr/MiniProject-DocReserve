import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../models/produk.dart';
import '../../services/produk_service.dart';

part 'produk_event.dart';
part 'produk_state.dart';

class ProdukBloc extends Bloc<ProdukEvent, ProdukState> {
  final ProdukService produkService;
  ProdukBloc({required this.produkService}) : super(ProdukInitial()) {
    on<LoadProduk>((event, emit) async {
      emit(ProdukLoading());
      try {
        final result = await produkService.getProduk();
        emit(ProdukLoaded(result));
      } catch (e) {
        emit(ProdukError(e.toString()));
      }
    });
  }
}