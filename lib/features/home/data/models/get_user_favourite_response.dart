import 'package:equatable/equatable.dart';

// Product model
class FavouriteProduct extends Equatable {
  final int id;
  final int userId;
  final int type;
  final int ord;
  final String isUsed;
  final int categoryId;
  final int countryId;
  final int brandId;
  final String name;
  final String nameEn;
  final String details;
  final String detailsEn;
  final int colorId;
  final String tag;
  final String tagEn;
  final dynamic taxId;
  final String price;
  final int discount;
  final dynamic sku;
  final int quantity;
  final int notifiQuantity;
  final int stokeId;
  final dynamic repositoryNumber;
  final String img;
  final String productCode;
  final dynamic hashNumber;
  final dynamic barcode;
  final String barcodeNumber;
  final int weight;
  final dynamic numViews;
  final String isActive;
  final dynamic deletedAt;
  final String createdAt;
  final String updatedAt;
  final dynamic userIp;
  final dynamic userPcInfo;
  final dynamic userAdded;

  const FavouriteProduct({
    required this.id,
    required this.userId,
    required this.type,
    required this.ord,
    required this.isUsed,
    required this.categoryId,
    required this.countryId,
    required this.brandId,
    required this.name,
    required this.nameEn,
    required this.details,
    required this.detailsEn,
    required this.colorId,
    required this.tag,
    required this.tagEn,
    this.taxId,
    required this.price,
    required this.discount,
    this.sku,
    required this.quantity,
    required this.notifiQuantity,
    required this.stokeId,
    this.repositoryNumber,
    required this.img,
    required this.productCode,
    this.hashNumber,
    this.barcode,
    required this.barcodeNumber,
    required this.weight,
    this.numViews,
    required this.isActive,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.userIp,
    this.userPcInfo,
    this.userAdded,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        ord,
        isUsed,
        categoryId,
        countryId,
        brandId,
        name,
        nameEn,
        details,
        detailsEn,
        colorId,
        tag,
        tagEn,
        taxId,
        price,
        discount,
        sku,
        quantity,
        notifiQuantity,
        stokeId,
        repositoryNumber,
        img,
        productCode,
        hashNumber,
        barcode,
        barcodeNumber,
        weight,
        numViews,
        isActive,
        deletedAt,
        createdAt,
        updatedAt,
        userIp,
        userPcInfo,
        userAdded,
      ];

  factory FavouriteProduct.fromJson(Map<String, dynamic> json) {
    return FavouriteProduct(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      ord: json['ord'],
      isUsed: json['is_used'],
      categoryId: json['category_id'],
      countryId: json['country_id'],
      brandId: json['brand_id'],
      name: json['name'],
      nameEn: json['name_en'],
      details: json['details'],
      detailsEn: json['details_en'],
      colorId: json['color_id'],
      tag: json['tag'],
      tagEn: json['tag_en'],
      taxId: json['tax_id'],
      price: json['price'],
      discount: json['discount'],
      sku: json['sku'],
      quantity: json['quantity'],
      notifiQuantity: json['notifi_quantity'],
      stokeId: json['stoke_id'],
      repositoryNumber: json['repository_number'],
      img: json['img'],
      productCode: json['product_code'],
      hashNumber: json['hash_number'],
      barcode: json['barcode'],
      barcodeNumber: json['barcode_number'],
      weight: json['weight'],
      numViews: json['num_views'],
      isActive: json['is_active'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userIp: json['user_ip'],
      userPcInfo: json['user_pc_info'],
      userAdded: json['user_added'],
    );
  }
}

// Favourite data model
class FavouriteData extends Equatable {
  final int id;
  final int favoId;
  final double priceWithDiscount;
  final FavouriteProduct? product;

  const FavouriteData({
    required this.id,
    required this.favoId,
    required this.priceWithDiscount,
    this.product,
  });

  @override
  List<Object?> get props => [id, favoId, priceWithDiscount, product];

  factory FavouriteData.fromJson(Map<String, dynamic> json) {
    return FavouriteData(
      id: json['id'],
      favoId: json['favo_id'],
      priceWithDiscount: json['price_with_discount'].toDouble(),
      product:
          json['product'] != null ? FavouriteProduct.fromJson(json['product']) : null,
    );
  }
}

// Main response model
class GetUserFavouriteResponse extends Equatable {
  final bool result;
  final String errorMessage;
  final String errorMessageEn;
  final List<FavouriteData> data;

  const GetUserFavouriteResponse({
    required this.result,
    required this.errorMessage,
    required this.errorMessageEn,
    required this.data,
  });

  @override
  List<Object?> get props => [result, errorMessage, errorMessageEn, data];

  factory GetUserFavouriteResponse.fromJson(Map<String, dynamic> json) {
    return GetUserFavouriteResponse(
      result: json['result'],
      errorMessage: json['error_message'],
      errorMessageEn: json['error_message_en'],
      data:
          (json['data'] as List).map((e) => FavouriteData.fromJson(e)).toList(),
    );
  }
}
