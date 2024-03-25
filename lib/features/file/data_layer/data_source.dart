import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../core/errors/exceptions.dart';
import 'model.dart';

abstract class BaseRemoteFileDataSource {
  Future<File?> pickFile();
  Future<String> createFile(FileModel fileModel);
  Future<String> updateFile(FileModel fileModel);
  Future<Unit> deleteFile(String filePath);
  Future<Unit> downloadFile(String filePath);
}

class RemoteFileDataSource implements BaseRemoteFileDataSource {
  @override
  Future<File?> pickFile() async {
    try {
      //try to pick a file
      //If it is successful return this file,
      //If it is NOT successful throw an unknown exception

      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        return file;
      } else {
        return null;
      }
    } catch (e) {
      print('actual error ------------------------');
      print(e.toString());
      throw UnkownException();
    }
  }

  @override
  Future<String> createFile(FileModel fileModel) async {
    try {
      //try to upload it ti firestorage
      //If it is successful return its down,
      //If it is NOT successful throw an server exception

      final storageRef = FirebaseStorage.instance.ref(fileModel.path);
      await storageRef.putFile(fileModel.file);
      return storageRef.getDownloadURL();
    } catch (e) {
      print('actual error ------------------------');
      print(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteFile(String filePath) {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }

  @override
  Future<Unit> downloadFile(String filePath) {
    // TODO: implement downloadFile
    throw UnimplementedError();
  }

  @override
  Future<String> updateFile(FileModel fileModel) {
    // TODO: implement updateFile
    throw UnimplementedError();
  }
}
