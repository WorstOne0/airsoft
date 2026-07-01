import 'package:flutter/foundation.dart';

/// The authenticated player. Extend with airsoft-specific fields as the
/// backend firms up (callsign/nickname, team, role, verified status…).
@immutable
class AuthUser {
  const AuthUser({required this.id, required this.name, required this.email, this.nickname, this.picture, this.team});

  final String id;

  final String name;
  final String email;

  final String? nickname;
  final String? picture;
  final String? team;

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      nickname: json['nickname'] as String?,
      picture: json['picture'] as String?,
      team: json['team'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'nickname': nickname, 'picture': picture, 'team': team};
  }

  AuthUser copyWith({String? name, String? nickname, String? picture, String? team}) {
    return AuthUser(
      id: id,
      email: email,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      picture: picture ?? this.picture,
      team: team ?? this.team,
    );
  }
}
