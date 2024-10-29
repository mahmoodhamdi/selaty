import 'package:equatable/equatable.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';

// ProductState to manage the state of ProductCubit
class ProductState extends Equatable {
  final ProductStatus status;
  final List<Product>? products;
  final String? errorMessage;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products,
    this.errorMessage,
  });

  // Create a copy of the state with new values (for immutability)
  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage];
}
