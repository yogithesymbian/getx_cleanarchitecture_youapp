import 'dart:io';

/// Simple converter dari model JSON → artools style
/// Jalankan: dart run bin/convert_artools.dart lib/app/models/user_model.dart
void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart run bin/convert_artools.dart <file.dart>');
    exit(1);
  }

  final file = File(args[0]);

  if (!file.existsSync()) {
    print('❌ File not found: ${args[0]}');
    exit(1);
  }

  var content = file.readAsStringSync();

  // Hapus import json bawaan
  content = content.replaceAll(RegExp(r"import 'dart:convert';\n"), "");

  // Tambahkan import artools
  if (!content.contains("package:artools/artools.dart")) {
    content = "import 'package:artools/artools.dart';\n\n$content";
  }

  // Rename class Users → User (opsional: bisa kamu ubah sesuai kebutuhan)
  content = content.replaceAllMapped(
      RegExp(r'class\s+Users'), (m) => 'class User extends Model');

  // Ubah class lain biar extend Model
  content = content.replaceAllMapped(
      RegExp(r'class\s+(\w+)\s*{'), (m) => 'class ${m[1]} extends Model {');

  // Hapus factory fromRawJson dan toRawJson
  content = content.replaceAll(
      RegExp(r'factory\s+\w+\.fromRawJson[^{]+\{[^}]+\}\n', dotAll: true), "");
  content =
      content.replaceAll(RegExp(r'String\s+toRawJson\(\)\s*=>[^\n]+\n'), "");

  // Ubah factory fromJson → pakai Model.*FromJson
  content = content.replaceAllMapped(
    RegExp(r'(\w+):\s*json\["(\w+)"\]'),
    (m) {
      final varName = m[1]!;
      final key = m[2]!;
      if (varName.toLowerCase().contains("id")) {
        return "$varName: Model.intFromJson(json, '$key')";
      } else if (varName.toLowerCase().contains("auth")) {
        return "$varName: Model.boolFromJson(json, '$key')";
      } else {
        return "$varName: Model.stringFromJson(json, '$key')";
      }
    },
  );

  // Generate toString otomatis kalau belum ada
  if (!content.contains("toString()")) {
    final props = RegExp(r'(\w+\??\s+\w+;)').allMatches(content).map((m) {
      final parts = m[0]!.replaceAll(";", "").trim().split(" ");
      return parts.last;
    }).toList();

    final toStringBody = props.map((p) => "'$p: \$$p'").join(" + ', ' + ");

    content = content.replaceFirstMapped(
      RegExp(r'\}\s*$'), // sebelum penutup class
      (m) => '''

  @override
  String toString() {
    return '\${runtimeType}{' + $toStringBody + '}';
  }
}''',
    );
  }

  file.writeAsStringSync(content);
  print("✅ Converted: ${file.path}");
}
