import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../models/artikel.dart';
import '../../services/artikel_service.dart';

part 'artikel_event.dart';
part 'artikel_state.dart';

class ArtikelBloc extends Bloc<ArtikelEvent, ArtikelState> {
  final ArtikelService artikelService;
  ArtikelBloc({required this.artikelService}) : super(ArtikelInitial()) {
    on<LoadArtikel>((event, emit) async {
      emit(ArtikelLoading());
      try {
        final result = await artikelService.getArtikel();
        emit(ArtikelLoaded(result));
      } catch (e) {
        emit(ArtikelError(e.toString()));
      }
    });
  }
}