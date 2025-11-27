class RoleModel {
  const RoleModel({
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    final statusValue = json['status'];
    final isActive = statusValue is bool
        ? statusValue
        : ((statusValue is num) ? statusValue == 1 : false);

    return RoleModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: (json['role'] ?? json['name'] ?? '').toString(),
      isActive: isActive,
    );
  }

  final int id;
  final String name;
  final bool isActive;
}
