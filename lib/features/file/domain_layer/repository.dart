import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import 'entity.dart';

abstract class BaseFileRepository {
  Future<Either<Failure, File?>> pickFile();
  Future<Either<Failure, String>> createFile(FileEntity fileEntity);
  Future<Either<Failure, String>> updateFile(FileEntity fileEntity);
  Future<Either<Failure, Unit>> deleteFile(String filePath);
  Future<Either<Failure, Unit>> downloadFile(String filePath);
}
