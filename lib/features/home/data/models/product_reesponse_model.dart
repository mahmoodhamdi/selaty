class ProductResponse {
  bool status;
  String message;
  ProductData data;

  ProductResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      status: json['status'],
      message: json['message'] ?? "",
      data: ProductData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ProductData {
  int currentPage;
  List<Product> products;

  ProductData({
    required this.currentPage,
    required this.products,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      currentPage: json['current_page'],
      products:
          List<Product>.from(json['data'].map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': List<dynamic>.from(products.map((x) => x.toJson())),
    };
  }
}

class Product {
  int id;
  int userId;
  int type;
  int ord;
  String isUsed;
  int categoryId;
  int countryId;
  int brandId;
  String name;
  String nameEn;
  String details;
  String detailsEn;
  int colorId;
  String tag;
  String tagEn;
  String? taxId;
  String price;
  int discount;
  String? sku;
  int quantity;
  int notifiQuantity;
  int stokeId;
  String? repositoryNumber;
  String img;
  String productCode;
  String? hashNumber;
  String? barcode;
  String barcodeNumber;
  int weight;
  int? numViews;
  String isActive;
  String? deletedAt;
  String createdAt;
  String updatedAt;
  String? userIp;
  String? userPcInfo;
  String? userAdded;
  double priceAfterDiscount;
  int isFavorite;
  List<ProductAttribute> productAttributes;

  Product({
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
    required this.priceAfterDiscount,
    required this.isFavorite,
    required this.productAttributes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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
      tag: json['tag'] ?? '',
      tagEn: json['tag_en'] ?? '',
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
      priceAfterDiscount: json['price_after_discount']?.toDouble() ?? 0.0,
      isFavorite: json['is_favorite'],
      productAttributes: List<ProductAttribute>.from(
          json['product_attributes'].map((x) => ProductAttribute.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'ord': ord,
      'is_used': isUsed,
      'category_id': categoryId,
      'country_id': countryId,
      'brand_id': brandId,
      'name': name,
      'name_en': nameEn,
      'details': details,
      'details_en': detailsEn,
      'color_id': colorId,
      'tag': tag,
      'tag_en': tagEn,
      'tax_id': taxId,
      'price': price,
      'discount': discount,
      'sku': sku,
      'quantity': quantity,
      'notifi_quantity': notifiQuantity,
      'stoke_id': stokeId,
      'repository_number': repositoryNumber,
      'img': img,
      'product_code': productCode,
      'hash_number': hashNumber,
      'barcode': barcode,
      'barcode_number': barcodeNumber,
      'weight': weight,
      'num_views': numViews,
      'is_active': isActive,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_ip': userIp,
      'user_pc_info': userPcInfo,
      'user_added': userAdded,
      'price_after_discount': priceAfterDiscount,
      'is_favorite': isFavorite,
      'product_attributes':
          List<dynamic>.from(productAttributes.map((x) => x.toJson())),
    };
  }
}

class ProductAttribute {
  int id;
  int ord;
  int productId;
  int sizeId;
  int colorId;
  String amount;
  int newQuantity;
  int allQuantity;
  String? price;
  String? img;
  String isActive;
  String? deletedAt;
  String createdAt;
  String updatedAt;
  String? userIp;
  String? userPcInfo;
  Size size;
  Color color;

  ProductAttribute({
    required this.id,
    required this.ord,
    required this.productId,
    required this.sizeId,
    required this.colorId,
    required this.amount,
    required this.newQuantity,
    required this.allQuantity,
    this.price,
    this.img,
    required this.isActive,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.userIp,
    this.userPcInfo,
    required this.size,
    required this.color,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      id: json['id'],
      ord: json['ord'],
      productId: json['product_id'],
      sizeId: json['size_id'],
      colorId: json['color_id'],
      amount: json['amount'],
      newQuantity: json['new_quantity'],
      allQuantity: json['all_quantity'],
      price: json['price'],
      img: json['img'],
      isActive: json['is_active'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userIp: json['user_ip'],
      userPcInfo: json['user_pc_info'],
      size: Size.fromJson(json['size']),
      color: Color.fromJson(json['color']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ord': ord,
      'product_id': productId,
      'size_id': sizeId,
      'color_id': colorId,
      'amount': amount,
      'new_quantity': newQuantity,
      'all_quantity': allQuantity,
      'price': price,
      'img': img,
      'is_active': isActive,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_ip': userIp,
      'user_pc_info': userPcInfo,
      'size': size.toJson(),
      'color': color.toJson(),
    };
  }
}

class Size {
  int id;
  int ord;
  int attributeId;
  String name;
  String nameEn;
  String value;
  String? valueEn;
  String? deletedAt;
  String isActive;
  String createdAt;
  String updatedAt;

  Size({
    required this.id,
    required this.ord,
    required this.attributeId,
    required this.name,
    required this.nameEn,
    required this.value,
    this.valueEn,
    this.deletedAt,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      id: json['id'],
      ord: json['ord'],
      attributeId: json['attribute_id'],
      name: json['name'],
      nameEn: json['name_en'],
      value: json['value'],
      valueEn: json['value_en'],
      deletedAt: json['deleted_at'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ord': ord,
      'attribute_id': attributeId,
      'name': name,
      'name_en': nameEn,
      'value': value,
      'value_en': valueEn,
      'deleted_at': deletedAt,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Color {
  int id;
  String color;
  String hex;

  Color({
    required this.id,
    required this.color,
    required this.hex,
  });

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      id: json['id']??0,
      color: json['color']??'',
      hex: json['hex']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color,
      'hex': hex,
    };
  }
}
