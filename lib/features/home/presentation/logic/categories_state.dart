import 'package:equatable/equatable.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';

class CategoriesState extends Equatable {
  final CategoriesStatus status;
  final List<Category>? categories;
  final String? errorMessage;

  const CategoriesState({
    this.status = CategoriesStatus.initial,
    this.categories,
    this.errorMessage,
  });

  // Copy with method to update the state
  CategoriesState copyWith({
    CategoriesStatus? status,
    List<Category>? categories,
    String? errorMessage,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, categories, errorMessage];
}
