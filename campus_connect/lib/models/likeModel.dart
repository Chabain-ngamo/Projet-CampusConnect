import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class LikeModel with ChangeNotifier {
  final String id, publicationId;

  LikeModel({
    required this.id,
    required this.publicationId,
  });
}
