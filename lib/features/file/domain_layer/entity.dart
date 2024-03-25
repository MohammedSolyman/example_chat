import 'dart:io';
import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final String path;
  final File file;

  const FileEntity({
    required this.path,
    required this.file,
  });

  @override
  List<Object> get props => [path, file];
}
