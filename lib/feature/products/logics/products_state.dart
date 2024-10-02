part of 'products_cubit.dart';

class ProductsState extends Equatable {
  const ProductsState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.products = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final List<ProductsResponseData> products;

  ProductsState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<ProductsResponseData>? products,
  }) {
    return ProductsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        products,
      ];
}
