import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/produk.dart';
import '../../services/produk_service.dart';

part 'produk_event.dart';
part 'produk_state.dart';

class ProdukBloc extends Bloc<ProdukEvent, ProdukState> {
  final ProdukService produkService;
  ProdukBloc({required this.produkService}) : super(ProdukInitial()) {
    on<LoadProduk>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      emit(ProdukLoading());
      try {
        final result = await produkService.getProdukFirebase(token: token!);
        emit(ProdukLoaded(result));
      } catch (e) {
        emit(ProdukError(e.toString()));
      }
    });
  }
}
