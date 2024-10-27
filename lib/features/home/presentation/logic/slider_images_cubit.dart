import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/domain/usecases/get_slider_images_usecase.dart';
import 'package:selaty/features/home/presentation/logic/slider_images_state.dart';

class SliderImagesCubit extends Cubit<SliderImagesState> {

  SliderImagesCubit()
      : super(SliderImagesState(status: SliderImagesStatus.initial));

  Future<void> fetchSliderImages() async {
    emit(state.copyWith(status: SliderImagesStatus.loading));
    final result = await sl<GetSliderImagesUseCase>().call();

    result.fold(
      (failure) => emit(state.copyWith(
          status: SliderImagesStatus.failure, errorMessage: failure)),
      (images) => emit(
          state.copyWith(status: SliderImagesStatus.success, images: images)),
    );
  }
}
