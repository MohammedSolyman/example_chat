import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../core/errors/error_messages.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/network_info/network_info.dart';
import '../domain_layer/entity.dart';
import '../domain_layer/repository.dart';
import 'data_source.dart';
import 'model.dart';

class FileRepository implements BaseFileRepository {
  final BaseRemoteFileDataSource baseRemoteFileDataSource;
  final NetworkInfo networkInfo;

  FileRepository(
      {required this.baseRemoteFileDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, String>> createFile(FileEntity fileEntity) async {
    FileModel fileModel = FileModel.fromEntity(fileEntity);

    if (await networkInfo.isConnected) {
      try {
        String downloadLink =
            await baseRemoteFileDataSource.createFile(fileModel);

        return Right(downloadLink);
      } on ServerException {
        return const Left(
            ServerFailure(failureMessage: ErrorMessages.serverError));
      }
    } else {
      return const Left(
          NoConnectionFailure(failureMessage: ErrorMessages.noConnection));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteFile(String filePath) {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> downloadFile(String filePath) {
    // TODO: implement downloadFile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updateFile(FileEntity fileEntity) {
    // TODO: implement updateFile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, File?>> pickFile() async {
    try {
      File? file = await baseRemoteFileDataSource.pickFile();
      return Right(file);
    } on UnknownFailure {
      return const Left(
          ServerFailure(failureMessage: ErrorMessages.unknownError));
    }
  }
}
