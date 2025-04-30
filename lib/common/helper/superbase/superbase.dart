import 'dart:io';

import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<String> uploadImageToSupabase(File imageFile) async {
  final supabase = Supabase.instance.client;

  final fileName =
      '${DateTime.now().millisecondsSinceEpoch}_${basename(imageFile.path)}';
  final fileBytes = await imageFile.readAsBytes();
  final contentType = lookupMimeType(imageFile.path);

  final response = await supabase.storage
      .from('fashsion')
      .uploadBinary(
        fileName,
        fileBytes,
        fileOptions: FileOptions(contentType: contentType ?? 'image/jpeg'),
      );

  if (response.isEmpty) {
    throw Exception('Upload failed');
  }

  // Lấy URL công khai (nếu bucket là public)
  final publicUrl = supabase.storage.from('fashsion').getPublicUrl(fileName);
  return publicUrl;
}
