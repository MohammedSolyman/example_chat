import 'dart:convert';
import 'dart:io';
import '../domain_layer/entity.dart';

class FileModel extends FileEntity {
  const FileModel({required super.path, required super.file});

  FileModel copyWith({
    String? path,
    File? file,
  }) {
    return FileModel(
      path: path ?? this.path,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'file': file,
    };
  }

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      path: map['path'],
      file: map['file'],
    );
  }

  factory FileModel.fromEntity(FileEntity fileEntity) {
    return FileModel(
      path: fileEntity.path,
      file: fileEntity.file,
    );
  }

  FileEntity toEntity() {
    return FileEntity(path: path, file: file);
  }

  String toJson() => json.encode(toMap());

  factory FileModel.fromJson(String source) =>
      FileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
