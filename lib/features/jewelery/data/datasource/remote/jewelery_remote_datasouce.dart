import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/app/constants/api_endpoint.dart';
import 'package:gemchase_clean_arch/core/failure/failure.dart';
import 'package:gemchase_clean_arch/core/networking/remote/http_service.dart';
import 'package:gemchase_clean_arch/features/jewelery/data/model/jewelery_api_model.dart';
import 'package:gemchase_clean_arch/features/jewelery/domain/entity/jewelery_entity.dart';

 
final jeweleryRemoteDatasourceProvider = Provider(
  (ref) => JeweleryRemoteDatasource(
    dio: ref.read(httpServiceProvider),
    jeweleryApiModel: ref.read(jeweleryApiModelProvider),
  ),
);
 
class JeweleryRemoteDatasource {
  final Dio dio;
  final JeweleryApiModel jeweleryApiModel;
 
  JeweleryRemoteDatasource({
    required this.dio,
    required this.jeweleryApiModel,
  });
 
  Future<Either<Failure, List<JeweleryEntity>>> getAllJewelerys(int page) async {
    try {
      var response = await dio.get(ApiEndpoints.getJewelerys, queryParameters: {
          'page': page,
          'limit': ApiEndpoints.limitPage,
        },
      );
      if (response.statusCode == 201) {
        return Right((response.data['jewelerys'] as List)
            .map((jewelery) => JeweleryApiModel.fromJson(jewelery).toEntity())
            .toList());
        // //OR
        // //2nd way
        // GetAllJeweleryDTO jeweleryAddDTO = GetAllJeweleryDTO.fromJson(response.data);
        // return Right(JeweleryApiModel.toEntityList(jeweleryAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }
}