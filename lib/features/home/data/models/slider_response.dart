import 'package:equatable/equatable.dart';

class SliderResponse extends Equatable {
  final bool result;
  final String errorMessage;
  final String errorMessageEn;
  final List<SliderResponseData>? data;

  const SliderResponse({
    required this.result,
    required this.errorMessage,
    required this.errorMessageEn,
    required this.data,
  });

  @override
  List<Object?> get props => [result, errorMessage, errorMessageEn, data];

  factory SliderResponse.fromJson(Map<String, dynamic> json) {
    return SliderResponse(
      result: json['result'],
      errorMessage: json['error_message'] ?? '',
      errorMessageEn: json['error_message_en'] ?? '',
      data: json['data'] != null
          ? List<SliderResponseData>.from(
              json['data'].map((item) => SliderResponseData.fromJson(item)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'error_message': errorMessage,
      'error_message_en': errorMessageEn,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class SliderResponseData extends Equatable {
  final int id;
  final int ord;
  final String type;
  final String? name;
  final String img;
  final String? urlL;
  final int withId;

  const SliderResponseData({
    required this.id,
    required this.ord,
    required this.type,
    this.name,
    required this.img,
    this.urlL,
    required this.withId,
  });

  @override
  List<Object?> get props => [id, ord, type, name, img, urlL, withId];

  factory SliderResponseData.fromJson(Map<String, dynamic> json) {
    return SliderResponseData(
      id: json['id'],
      ord: json['ord'],
      type: json['type'].toString(),
      name: json['name'],
      img: json['img'],
      urlL: json['url_l'],
      withId: json['with_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ord': ord,
      'type': type,
      'name': name,
      'img': img,
      'url_l': urlL,
      'with_id': withId,
    };
  }
}
