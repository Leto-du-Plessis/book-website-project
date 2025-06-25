import 'dart:typed_data';

class User {

  final String username;
  final Uint8List? profileImageBytes;
  final List<String>? ownedBookIds;

  User({
    required this.username,
    this.profileImageBytes,
    this.ownedBookIds,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(  
      username: json['username'],
      profileImageBytes: json['profileImage'] != null
        ? Uint8List.fromList(List<int>.from(json['profileImage']))
        : null,
      ownedBookIds: json['ownedBookIds'] ?? [],
    );
  }
}