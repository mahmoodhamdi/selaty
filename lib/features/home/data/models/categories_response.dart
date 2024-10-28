import 'package:equatable/equatable.dart';

// CategoriesResponse Model
class CategoriesResponse extends Equatable {
  final bool result;
  final String errorMessage;
  final String errorMessageEn;
  final List<Category> data;

  const CategoriesResponse({
    required this.result,
    required this.errorMessage,
    required this.errorMessageEn,
    required this.data,
  });

  @override
  List<Object?> get props => [result, errorMessage, errorMessageEn, data];

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      result: json['result'] ?? false,
      errorMessage: json['error_message'] ?? '',
      errorMessageEn: json['error_message_en'] ?? '',
      data: json['data'] != null
          ? List<Category>.from(json['data'].map((x) => Category.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'error_message': errorMessage,
      'error_message_en': errorMessageEn,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

// Category Model
class Category extends Equatable {
  final int id;
  final int ord;
  final String type;
  final int parentId;
  final String name;
  final String img;
  final String details;
  final List<SubCategory> subCat;

  const Category({
    required this.id,
    required this.ord,
    required this.type,
    required this.parentId,
    required this.name,
    required this.img,
    required this.details,
    required this.subCat,
  });

  @override
  List<Object?> get props =>
      [id, ord, type, parentId, name, img, details, subCat];

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      ord: json['ord'] ?? 0,
      type: json['type'] ?? '',
      parentId: json['parent_id'] ?? 0,
      name: json['name'] ?? '',
      img: json['img'] ?? '',
      details: json['details'] ?? '',
      subCat: json['sub_cat'] != null
          ? List<SubCategory>.from(
              json['sub_cat'].map((x) => SubCategory.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ord': ord,
      'type': type,
      'parent_id': parentId,
      'name': name,
      'img': img,
      'details': details,
      'sub_cat': List<dynamic>.from(subCat.map((x) => x.toJson())),
    };
  }
}

// SubCategory Model
class SubCategory extends Equatable {
  final int id;
  final int ord;
  final String type;
  final int parentId;
  final String name;
  final String img;
  final String details;

  const SubCategory({
    required this.id,
    required this.ord,
    required this.type,
    required this.parentId,
    required this.name,
    required this.img,
    required this.details,
  });

  @override
  List<Object?> get props => [id, ord, type, parentId, name, img, details];

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? 0,
      ord: json['ord'] ?? 0,
      type: json['type'] ?? '',
      parentId: json['parent_id'] ?? 0,
      name: json['name'] ?? '',
      img: json['img'] ?? '',
      details: json['details'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ord': ord,
      'type': type,
      'parent_id': parentId,
      'name': name,
      'img': img,
      'details': details,
    };
  }
}
