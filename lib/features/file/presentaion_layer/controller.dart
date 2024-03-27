// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../../core/constants/firebase_paths.dart';
import '../../../core/errors/failures.dart';
import '../data_layer/model.dart';
import '../domain_layer/entity.dart';
import '../domain_layer/use_cases.dart';
import 'package:path/path.dart';

class FileController extends GetxController {
  CreateFileUseCase createFileUseCase;
  PickFileUseCase pickFileUseCase;
  UpdateFileUseCase updateFileUseCase;
  DeleteFileUseCase deleteFileUseCase;
  DownloadFileUseCase downloadFileUseCase;

  FileController({
    required this.createFileUseCase,
    required this.pickFileUseCase,
    required this.updateFileUseCase,
    required this.deleteFileUseCase,
    required this.downloadFileUseCase,
  });
  ///////////////////////////////////////////////////////////////////
  // 1. picking files
  Future<File?> pickFileFunction() async {
    Either<Failure, File?> result = await pickFileUseCase.pickFile();

    return result.fold((l) {}, (File? file) {
      return file;
    });
  }

  ///////////////////////////////////////////////////////////////////
  // 2. preparing file models
  FileModel prepareMesageFile({required File file, required String roomId}) {
    String prefix = roomId.startsWith('contact')
        ? FirebasePath.contactsRooms
        : FirebasePath.groupsRooms;

    String now = DateTime.now().toString();

    String baseName = basename(file.path);
    String extension = baseName.split('.')[1];

    return FileModel(path: '$prefix/$roomId/$now.$extension', file: file);
  }

  FileModel prepareProfileFile(
      {required File file, required String id, required bool isGroup}) {
    String prefix =
        isGroup ? FirebasePath.groupsInfo : FirebasePath.contactsInfo;

    String baseName = basename(file.path);
    String extension = baseName.split('.')[1];

    return FileModel(path: '$prefix/$id/$id.$extension', file: file);
  }

  ///////////////////////////////////////////////////////////////////
  // 3. creating files
  Future<String?> createFileFunction(FileModel fileModel) async {
    FileEntity fileEntity = fileModel.toEntity();
    Either<Failure, String> result =
        await createFileUseCase.createFile(fileEntity);

    return result.fold((l) {}, (String downloadLink) => downloadLink);
  }
}
