import 'dart:convert';

import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/data/providers/student_provider.dart';
import 'package:univalle_app/models/models.dart';

class StudentRepository {
  StudentRepository({
    required StorageProvider storageProvider,
  }) : _provider = StudentProvider(storageProvider: storageProvider);

  final StudentProvider _provider;

  Future<Student> getStudent() async {
    final response = await _provider.requestCurrentStudents();
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final student = Student.fromJson(json['student']);
    return student;
  }
}
