import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 4)
class UsernameModal {

  @HiveField(0)
  final String username;

  UsernameModal({
    required this.username,
  });
}
