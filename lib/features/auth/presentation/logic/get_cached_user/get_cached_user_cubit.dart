// get_cached_user_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:selaty/features/auth/presentation/logic/get_cached_user/get_cached_user_state.dart';

class CachedUserCubit extends Cubit<CachedUserState> {
  final GetCachedUserUsecase getCachedUserUsecase;

  CachedUserCubit({
    GetCachedUserUsecase? getCachedUserUsecase,
  })  : getCachedUserUsecase =
            getCachedUserUsecase ?? sl<GetCachedUserUsecase>(),
        super(const CachedUserState());

  Future<void> getCachedUser() async {
    emit(state.copyWith(status: CachedUserStatus.loading));

    try {
      final userData = await getCachedUserUsecase.call();
      if (userData != null) {
        emit(state.copyWith(
          status: CachedUserStatus.loaded,
          userData: userData,
        ));
      } else {
        emit(state.copyWith(
          status: CachedUserStatus.error,
          errorMessage:
              'لا يوجد بيانات مستخدم محفوظة', // No cached user data found
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CachedUserStatus.error,
        errorMessage:
            'حدث خطأ أثناء جلب بيانات المستخدم: $e', // Error fetching user data
      ));
    }
  }
}
