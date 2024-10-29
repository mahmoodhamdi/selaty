import 'package:selaty/core/enums/status.dart';

class CategoryNameState {
  final CategoryNameStatus status;
  final List<String> categoryNames;

  CategoryNameState({required this.status, required this.categoryNames});

  CategoryNameState copyWith({
    CategoryNameStatus? status,
    List<String>? categoryNames,
  }) {
    return CategoryNameState(
      status: status ?? this.status,
      categoryNames: categoryNames ?? this.categoryNames,
    );
  }
}
