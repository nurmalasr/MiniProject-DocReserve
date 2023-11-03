part of 'produk_bloc.dart';

@immutable
sealed class ProdukState {}

final class ProdukInitial extends ProdukState {}

final class ProdukLoading extends ProdukState {}

final class ProdukLoaded extends ProdukState {
  final List<Produk> products;
  ProdukLoaded(this.products);
}

final class ProdukError extends ProdukState {
  final String error;
  ProdukError(this.error);
}
