import 'package:equatable/equatable.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';



class ProductState extends Equatable {
  final ProductStatus status;
  final List<Product>? products;
  final String? errorMessage;
  final bool hasMoreData;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products,
    this.errorMessage,
    this.hasMoreData = true,
  });

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    String? errorMessage,
    bool? hasMoreData,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage, hasMoreData];
}
