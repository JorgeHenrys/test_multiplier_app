import 'package:test_multiplier_app/src/core/core.dart';

abstract class ConversationMapper {
  static ConversationEntity toEntity(ConversationModel model) {
    return ConversationEntity(
      id: model.id,
      title: model.title,
      messages: model.messages.map((m) => MessageMapper.toEntity(m)).toList(),
      updatedAt: DateTime.parse(model.updatedAt),
    );
  }

  static ConversationModel toModel(ConversationEntity entity) {
    return ConversationModel(
      id: entity.id,
      title: entity.title,
      messages: entity.messages.map((m) => MessageMapper.toModel(m)).toList(),
      updatedAt: entity.updatedAt.toString(),
    );
  }
}
