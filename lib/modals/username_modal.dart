
import 'package:hive_flutter/adapters.dart';
part 'username_modal.g.dart';

@HiveType(typeId: 4)
class UsernameModal extends HiveObject {
  @HiveField(0)
   String username;

  @HiveField(1)
  String? id;

  UsernameModal({
    required this.username,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  updateusername(String name)async{
  username = name;
  save();
  }
}
