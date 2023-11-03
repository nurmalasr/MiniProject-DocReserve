import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/artikel.dart';
import '../../services/artikel_service.dart';

part 'artikel_event.dart';
part 'artikel_state.dart';

class ArtikelBloc extends Bloc<ArtikelEvent, ArtikelState> {
  final ArtikelService artikelService;
  ArtikelBloc({required this.artikelService}) : super(ArtikelInitial()) {
    on<LoadArtikel>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      emit(ArtikelLoading());
      try {
        final result = await artikelService.getArtikelFirebase(token: token!);
        emit(ArtikelLoaded(result));
      } catch (e) {
        emit(ArtikelError(e.toString()));
      }
    });
  }
}
