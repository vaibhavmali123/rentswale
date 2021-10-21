import 'dart:convert';

import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:intl/intl.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/models/AllProductsModel.dart';
import 'package:rentswale/models/CheckCouponModel.dart';
import 'package:rentswale/models/CreateAccountModel.dart';
import 'package:rentswale/models/KycModel.dart';
import 'package:rentswale/models/LoginModel.dart';
import 'package:rentswale/models/OffersModel.dart';
import 'package:rentswale/models/OrderHistoryModel.dart';
import 'package:rentswale/models/ProductDetailsModel.dart';
import 'package:rentswale/models/ProductsListModel.dart';
import 'package:rentswale/models/SubcategoriesModel.dart';
import 'package:rentswale/models/forgot_password_model.dart';
import 'package:rentswale/models/kyc_check_model.dart';
import 'package:rentswale/models/profile_model.dart';
import 'package:rentswale/models/profile_update_model_response.dart';
import 'package:rentswale/models/verify_otp_model.dart';
import 'package:rentswale/networking/ApiHandler.dart';
import 'package:rentswale/networking/ApiProvider.dart';
import 'package:rentswale/networking/EndApi.dart';

class Repository {
  static Future<List<SubcategoryList>> getSubCategories(String categoryId) async {
    var request = {'category_id': categoryId};
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.subcategoryList, request: request).then((value) {
      List<SubcategoryList> listSubcategory = SubcategoriesModel.fromJson(value).subcategoryList;
      print("FROM repo ${listSubcategory?.length}");

      return listSubcategory;
    });
  }

  static Future<ProductsListModel> getProductList({String categoryId, String subCategoryId}) async {
    Database.initDatabase();
    var request = {'category_id': categoryId, "city_name": Database.getAddres() != null ? Database.getAddres() : "Pune"};
    if (subCategoryId != null) {
      request['subcategory_id'] = subCategoryId;
    }
    print("RREEQQ ${request}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.productList, request: request).then((value) {
      ProductsListModel productsListModel = ProductsListModel.fromJson(value);
      print("FROM repo ${productsListModel.statusCode}");

      return productsListModel;
    });
  }

  static Future<ProductsListModel> getProductHome({String address}) {
    Database.initDatabase();

    print("ADDRESS new ${Database.getAddres()}");

    var request = {"city_name": Database.getAddres() != null ? Database.getAddres() : "Pune"};
    var request2 = {"user_id": Database.getUserName()};

    print("REQUEST ${request} ${request2}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.productHome, request: request).then((value) {
      ProductsListModel productsListModel = ProductsListModel.fromJson(value);
      print("FROM repo ${productsListModel.statusCode}");

      return productsListModel;
    });
  }

  static Future<List<ProductDescription>> getProductDetails({String itemMasterId}) async {
    var request = {'item_master_id': itemMasterId};
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.productDetails, request: request).then((value) {
      List<ProductDescription> listProducts = ProductDetailsModel.fromJson(value).productDescription;
      print("FROM repo ${listProducts?.length}");

      return listProducts;
    });
  }

  static Future<CreateAccountModel> createAccount({String type, String name, String email, String mobileNumber, String password}) async {
    var request = {'name': name, 'email_address': email, 'username': mobileNumber, 'password': password, 'type': type};
    print("REQ ${request}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.register, request: request).then((value) {
      CreateAccountModel createAccountModel = CreateAccountModel.fromJson(value);
      return createAccountModel;
    });
  }

  static Future<LoginModel> login({String userName, String password}) async {
    var request = {'username': userName, 'password': password};
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.login, request: request).then((value) {
      LoginModel loginModel = LoginModel.fromJson(value);

      return loginModel;
    });
  }

  static Future<CheckCouponModel> applyCoupon({String coupon_code}) async {
    var request = {'coupon_code': coupon_code};
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.couponCode, request: request).then((value) {
      CheckCouponModel checkCouponModel = CheckCouponModel.fromJson(value);

      return checkCouponModel;
    });
  }

  static Future<dynamic> placeOrder({List<dynamic> placeOrderList, String address, String flatNo, String landmark, String direction}) {
    Database.initDatabase();
    print("ADDDDR ${Database.getEmail()} ${Database.getUserName()} ${Database.getUserId()}");
    DateTime dateTime = DateTime.now();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String date = dateFormat.format(dateTime);
    var request = {'order_arr': json.encode(placeOrderList), 'user_id': Database.getUserId(), 'user_name': Database.getUserName(), 'email': Database.getEmail(), 'phone': Database.getUserName(), 'address': address, 'date': date, 'flat_details': flatNo, 'landmark': landmark, 'direction': direction};
    print("REQUEST ${request.toString()}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.placeOrder, request: request).then((value) {
      print("RES From REPO ${value.toString()}");
      dynamic result = value;
      return result;
    });
  }

  static Future<List<AllProductList>> allProducts({String address}) {
    Database.initDatabase();
    String addr = Database.getAddres() != null ? Database.getAddres() : "Pune";
    var request = {"city_name": addr};
    print("REQUEST  ${request}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.allProducts, request: request).then((value) {
      print("FROM repo event ${value}");

      List<AllProductList> listProducts = AllProductsModel.fromJson(value).allProductList;

      return listProducts;
    });
  }

  static Future<KycModel> updateKyc({String aadharNo, String aadharCard, String addressProof, String licenseNo, String license}) {
    Database.initDatabase();

    var request = {'adhar_number': aadharNo, 'adhar_card': aadharCard, 'driving_licence': license, 'driving_licence_number': licenseNo, 'address_proof': addressProof, 'username': Database.getUserName()};
    print("REQUEST ${request}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.kyc, request: request).then((value) {
      print("REQUEST  RESPONSE ${value}");

      KycModel kycModel = KycModel.fromJson(value);

      return kycModel;
    });
  }

  static Future<OrderHistoryModel> getOrderHistory() {
    Database.initDatabase();
    var request = {"user_id": Database.getUserName()};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.orderHistory, request: request).then((value) {
      OrderHistoryModel orderHistoryModel = OrderHistoryModel.fromJson(value);

      return orderHistoryModel;
    });
  }

  static Future<OffersModel> getOffers() {
    return ApiHandler.getApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.offers).then((value) {
      OffersModel offersModel = OffersModel.fromJson(value);

      print("RESPONSE ${value}");

      return offersModel;
    });
  }

  static Future<ProfileUpdateModelResponse> updateProfile({String name, String email, String address, String profileImage, String floorNo, String landmark, String direction}) {
    var request = {"username": Database.getUserName(), "name": name, "email_address": email, "address": address, 'flat_details': floorNo, 'landmark': landmark, 'direction': direction};
    if (profileImage != null) {
      request["profile_image"] = profileImage;
    }

    print("REQUEST ${request}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.updateProfile, request: request).then((value) {
      ProfileUpdateModelResponse profileUpdateModelResponse = ProfileUpdateModelResponse.fromJson(value);

      return profileUpdateModelResponse;
    });
  }

  static Future<Map<String, dynamic>> uploadFile({fileName, directory}) async {
    Map<String, dynamic> map;
    final uploader = FlutterUploader();

    final taskId = await uploader.enqueue(url: ApiProvider.baseUrlUpload, files: [FileItem(filename: fileName, savedDir: directory)], method: UploadMethod.POST, headers: {"apikey": "api_123456", "userkey": "userkey_123456"}, showNotification: true);
    final subscription = uploader.progress.listen((progress) {
      print("Progress ${progress}");
    });

    final subscription1 = uploader.result.listen((result) {
      print("Progress result ${result.response}");

      // return result.response;
    }, onError: (ex, stacktrace) {});
    subscription1.onData((data) async {
      map = await json.decode(data.response);

      return map;
    });
  }

  static Future<ProfileModel> getProfile() async {
    Database.initDatabase();

    var request = {"username": Database.getUserName()};

    print("REQUEST ${request}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.profile, request: request).then((value) {
      ProfileModel profileModel = ProfileModel.fromJson(value);
      print("DDDDDDDDDDDDDD ${profileModel.statusCode}");

      return profileModel;
    });
  }

  static Future<ForgotPasswordModel> forgotPassword({String userName}) async {
    var request = {"username": userName};
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.forgotPassword, request: request).then((value) {
      ForgotPasswordModel forgotPasswordModel = ForgotPasswordModel.fromJson(value);

      return forgotPasswordModel;
    });
  }

  static Future<VerifyOtpModel> verifyOtp({String otp, String userName}) async {
    Database.initDatabase();
    var request = {"username": userName, "otp": otp};
    print("REQUEST ${request}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.verifyOtp, request: request).then((value) {
      VerifyOtpModel verifyOtpModel = VerifyOtpModel.fromJson(value);

      return verifyOtpModel;
    });
  }

  static Future<KycCheckModel> checkKyc() async {
    Database.initDatabase();

    var request = {"username": Database.getUserName()};
    print("FFFFFFFF ${request}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.kycCheck, request: request).then((value) {
      KycCheckModel kycCheckModel = KycCheckModel.fromJson(value);
      print("FFFFFFFF ${kycCheckModel.runtimeType}");

      return kycCheckModel;
    });
  }
}
