import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/app/constants/api_endpoint.dart';
import 'package:gemchase_clean_arch/core/failure/failure.dart';
import 'package:gemchase_clean_arch/core/networking/remote/http_service.dart';
import 'package:gemchase_clean_arch/core/shared_prefs/auth_shared_prefs.dart';
import 'package:gemchase_clean_arch/features/authentication/domain/entity/auth_entity.dart';


 
final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    authSharedPrefs: ref.read(authSharedPrefsProvider),
  ),
);
 
class AuthRemoteDataSource {
  final Dio dio;
  final AuthSharedPrefs authSharedPrefs;
  AuthRemoteDataSource({required this.dio, required this.authSharedPrefs});
  Future<Either<Failure, bool>> register(AuthEntity user) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          "firstName": user.firstName,
          "lastName": user.lastName,
         
          "email": user.email,
          "password": user.password,
          "confirmPassword": user.confirmpassword,
        },
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
 
  // Upload image using multipart
  // Future<Either<Failure, String>> uploadProfilePicture(
  //     File image,
  //     ) async {
  //   try {
  //     // Extract name from path
  //     // c:/user/username/pictures/image.png
  //     String fileName = image.path.split('/').last;
  //
  //     FormData formData = FormData.fromMap(
  //       {
  //         'profilePicture': await MultipartFile.fromFile(
  //           image.path,
  //           filename: fileName,
  //         ),
  //       },
  //     );
  //
  //     Response response = await dio.post(
  //       ApiEndpoints.uploadImage,
  //       data: formData,
  //     );
  //
  //     return Right(response.data["data"]);
  //   } on DioException catch (e) {
  //     return Left(
  //       Failure(
  //         error: e.error.toString(),
  //         statusCode: e.response?.statusCode.toString() ?? '0',
  //       ),
  //     );
  //   }
  // }
  Future<Either<Failure, bool>> login(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        // retrieve token
        // print({response.data["token"]});
        String token = response.data["token"];
        await authSharedPrefs.setAuthToken(token);
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}