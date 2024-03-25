import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import 'entity.dart';
import 'repository.dart';

class PickFileUseCase {
  BaseFileRepository baseFileRepository;
  PickFileUseCase({required this.baseFileRepository});

  Future<Either<Failure, File?>> pickFile() async {
    return await baseFileRepository.pickFile();
  }
}

class CreateFileUseCase {
  BaseFileRepository baseFileRepository;
  CreateFileUseCase({required this.baseFileRepository});

  Future<Either<Failure, String>> createFile(FileEntity fileEntity) async {
    return await baseFileRepository.createFile(fileEntity);
  }
}

class UpdateFileUseCase {
  BaseFileRepository baseFileRepository;
  UpdateFileUseCase({required this.baseFileRepository});

  Future<Either<Failure, String>> updateFile(FileEntity fileEntity) async {
    return await baseFileRepository.updateFile(fileEntity);
  }
}

class DeleteFileUseCase {
  BaseFileRepository baseFileRepository;
  DeleteFileUseCase({required this.baseFileRepository});

  Future<Either<Failure, Unit>> deleteFile(String filePath) async {
    return await baseFileRepository.deleteFile(filePath);
  }
}

class DownloadFileUseCase {
  BaseFileRepository baseFileRepository;
  DownloadFileUseCase({required this.baseFileRepository});

  Future<Either<Failure, Unit>> downloadFile(String filePath) async {
    return await baseFileRepository.downloadFile(filePath);
  }
}
