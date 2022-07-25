import 'package:hive_flutter/adapters.dart';
part 'username_modal.g.dart';

@HiveType(typeId: 4)
class UsernameModal {
  @HiveField(0)
  final String username;

  @HiveField(1)
  String? id;

  UsernameModal({
    required this.username,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
