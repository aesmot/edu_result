/// Admin dashboard-e dekhano ekta activity-r data.
class ActivityLog {
  const ActivityLog({
    required this.id,
    required this.actionType,
    required this.description,
    required this.createdAt,
    required this.status, // <-- এখানে 'required this.status' দিন
    this.actorId,
    this.actorName,
    this.entityType,
    this.entityId,
    this.metadata = const {},
  });

  final String id;
  final String? actorId;
  final String? actorName;
  final ActivityType actionType;
  final String? entityType;
  final String? entityId;
  final String description;
  final String status; // <-- ক্লাসের ভেতর ফিল্ডটি অবশ্যই থাকতে হবে
  final Map<String, dynamic> metadata;
  final DateTime createdAt;
}

/// Supabase-er `action_type` column-er jonno enum.
enum ActivityType {
  accountCreated('account_created'),
  markEntered('mark_entered'),
  markUpdated('mark_updated'),
  markDeleted('mark_deleted'),
  unknown('unknown');

  const ActivityType(this.value);

  final String value;

  /// Database-er string theke enum-e convert kore.
  static ActivityType fromValue(String? value) {
    return ActivityType.values.firstWhere(
          (type) => type.value == value,
      orElse: () => ActivityType.unknown,
    );
  }
}