class Pledge {
  final List<String> commitments;
  final DateTime createdDate;
  final Map<String, bool> progress; // commitment id -> completed today

  Pledge({
    required this.commitments,
    required this.createdDate,
    Map<String, bool>? progress,
  }) : progress = progress ?? {};

  Map<String, dynamic> toJson() => {
        'commitments': commitments,
        'createdDate': createdDate.toIso8601String(),
        'progress': progress,
      };

  factory Pledge.fromJson(Map<String, dynamic> json) => Pledge(
        commitments: List<String>.from(json['commitments']),
        createdDate: DateTime.parse(json['createdDate']),
        progress: Map<String, bool>.from(json['progress'] ?? {}),
      );

  Pledge copyWith({
    List<String>? commitments,
    DateTime? createdDate,
    Map<String, bool>? progress,
  }) {
    return Pledge(
      commitments: commitments ?? this.commitments,
      createdDate: createdDate ?? this.createdDate,
      progress: progress ?? this.progress,
    );
  }
}
