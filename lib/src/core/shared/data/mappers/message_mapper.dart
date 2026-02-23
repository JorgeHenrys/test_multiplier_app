import 'package:test_multiplier_app/src/core/core.dart';

abstract class MessageMapper {
  static MessageEntity toEntity(MessageModel model) {
    return MessageEntity(
      id: model.id,
      content: model.content,
      sender: model.sender == 'user'
          ? SenderEnum.user
          : model.sender == 'lara'
          ? SenderEnum.lara
          : SenderEnum.unknown,
      createdAt: DateTime.parse(model.createdAt),
    );
  }

  static MessageModel toModel(MessageEntity entity) {
    return MessageModel(
      id: entity.id,
      content: entity.content,
      sender: entity.sender.name,
      createdAt: entity.createdAt.toString(),
    );
  }
}
