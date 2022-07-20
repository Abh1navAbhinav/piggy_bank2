// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModalAdapter extends TypeAdapter<TransactionModal> {
  @override
  final int typeId = 3;

  @override
  TransactionModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModal(
      amount: fields[0] as int,
      date: fields[1] as DateTime,
      type: fields[2] as CategoryType,
      category: fields[3] as CategoryModal,
    )..id = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, TransactionModal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
