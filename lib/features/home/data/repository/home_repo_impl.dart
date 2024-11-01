import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/data/data_sources/home_local_data_source.dart';
import 'package:selaty/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/data/models/slider_response.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  @override
  Future<Either<String, List<SliderResponseData>>> getSliderImages() async {
    final localResult = await sl<HomeLocalDataSource>().getSliderImages();
    return localResult.fold(
      (error) async {
        final remoteResult = await sl<HomeRemoteDataSource>().getSliderImages();
        return remoteResult.fold(
          (error) => Left(error),
          (sliderImages) async {
            sl<HomeLocalDataSource>().cacheSliderImages(sliderImages);
            return Right(sliderImages);
          },
        );
      },
      (sliderImages) async {
        if (sliderImages.isEmpty) {
          final remoteResult =
              await sl<HomeRemoteDataSource>().getSliderImages();
          return remoteResult.fold(
            (error) => Left(error),
            (sliderImages) async {
              sl<HomeLocalDataSource>().cacheSliderImages(sliderImages);
              return Right(sliderImages);
            },
          );
        } else {
          return Right(sliderImages);
        }
      },
    );
  }

  @override
  Future<Either<String, List<Category>>> getCategories() async {
    final localResult = await sl<HomeLocalDataSource>().getCategories();

    return localResult.fold(
      (error) async {
        final remoteResult = await sl<HomeRemoteDataSource>().getCategories();
        return remoteResult.fold(
          (error) => Left(error),
          (categories) async {
            sl<HomeLocalDataSource>().cacheCategories(categories);
            return Right(categories);
          },
        );
      },
      (categories) async {
        if (categories.isEmpty) {
          final remoteResult = await sl<HomeRemoteDataSource>().getCategories();
          return remoteResult.fold(
            (error) => Left(error),
            (categories) async {
              sl<HomeLocalDataSource>().cacheCategories(categories);
              return Right(categories);
            },
          );
        } else {
          return Right(categories);
        }
      },
    );
  }

  @override
  Future<Either<String, List<Product>>> getProducts({required int page}) async {
    final localResult = await sl<HomeLocalDataSource>().getProducts();
    return localResult.fold(
      (error) async {
        final remoteResult =
            await sl<HomeRemoteDataSource>().getProducts(page: page);
        return remoteResult.fold(
          (error) => Left(error),
          (products) async {
            sl<HomeLocalDataSource>().cacheProducts(products);
            return Right(products);
          },
        );
      },
      (products) async {
        if (products.isEmpty) {
          final remoteResult =
              await sl<HomeRemoteDataSource>().getProducts(page: page);
          return remoteResult.fold((error) => Left(error), (products) async {
            sl<HomeLocalDataSource>().cacheProducts(products);
            return Right(products);
          });
        } else {
          return Right(products);
        }
      },
    );
  }

  @override
  Future<Either<String, List<FavouriteData>>> getUserFavourites() async {
    return await sl<HomeRemoteDataSource>().getUserFavourites();
  }
}
