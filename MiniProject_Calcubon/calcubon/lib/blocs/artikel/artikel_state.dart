part of 'artikel_bloc.dart';

@immutable
sealed class ArtikelState {}

final class ArtikelInitial extends ArtikelState {}

final class ArtikelLoading extends ArtikelState {}

final class ArtikelLoaded extends ArtikelState {
  final List<Artikel> artikels;
  ArtikelLoaded(this.artikels);
}

final class ArtikelError extends ArtikelState {
  final String error;
  ArtikelError(this.error);
}
