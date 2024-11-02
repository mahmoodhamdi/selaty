import 'package:equatable/equatable.dart';

class AddToFavouriteResponse extends Equatable {
  final bool result;
  final String errorMessage;
  final String errorMessageEn;
  final int? insertId; // Optional for adding

  const AddToFavouriteResponse({
    required this.result,
    required this.errorMessage,
    required this.errorMessageEn,
    this.insertId,
  });

  // Factory method to create an instance from JSON
  factory AddToFavouriteResponse.fromJson(Map<String, dynamic> json) {
    return AddToFavouriteResponse(
      result: json['result'],
      errorMessage: json['error_mesage'],
      errorMessageEn: json['error_mesage_en'],
      insertId: json['insert_id'], // Will be null if not present
    );
  }

  // Method to convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'error_mesage': errorMessage,
      'error_mesage_en': errorMessageEn,
      if (insertId != null) 'insert_id': insertId, // Include only if not null
    };
  }

  @override
  List<Object?> get props => [result, errorMessage, errorMessageEn, insertId];
}
