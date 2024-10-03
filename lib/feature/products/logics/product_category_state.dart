part of 'product_category_cubit.dart';

class ProductCategoryState extends Equatable {
  const ProductCategoryState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.categoryProduct = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final List<ProductCategoryData> categoryProduct;

  ProductCategoryState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<ProductCategoryData>? categoryProduct,
  }) {
    return ProductCategoryState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      categoryProduct: categoryProduct ?? this.categoryProduct,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        categoryProduct,
      ];
}
