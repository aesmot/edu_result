import '../../domain/entities/activity_log.dart';

class ActivityLogModel extends ActivityLog {
  const ActivityLogModel({
    required super.id,
    required super.actionType,
    required super.description,
    required super.createdAt,
    required String status, // <--- এভাবে লিখুন
    super.actorId,
    super.actorName,
    super.entityType,
    super.entityId,
    super.metadata,
  }) : super(status: status); // <--- সুপার কন্সট্রাক্টরে পাস করুন

  factory ActivityLogModel.fromJson(Map<String, dynamic> json) {
    return ActivityLogModel(
      id: json['id'] as String,
      actorId: json['actor_id'] as String?,
      actorName: json['actor_name'] as String?,
      actionType: ActivityType.fromValue(json['action_type'] as String?),
      entityType: json['entity_type'] as String?,
      entityId: json['entity_id'] as String?,
      description: json['description'] as String,
      status: (json['status'] as String?) ?? 'pending',
      metadata: (json['metadata'] as Map<String, dynamic>?) ?? const {},
      createdAt: DateTime.parse(json['created_at'] as String).toLocal(),
    );
  }
}