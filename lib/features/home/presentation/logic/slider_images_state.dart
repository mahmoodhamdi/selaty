import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/slider_response.dart';

class SliderImagesState {
  final SliderImagesStatus status;
  final List<SliderResponseData> images;
  final String? errorMessage;

  SliderImagesState({
    required this.status,
    this.images = const [],
    this.errorMessage,
  });

  SliderImagesState copyWith({
    SliderImagesStatus? status,
    List<SliderResponseData>? images,
    String? errorMessage,
  }) {
    return SliderImagesState(
      status: status ?? this.status,
      images: images ?? this.images,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
