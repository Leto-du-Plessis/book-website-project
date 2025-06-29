import 'dart:typed_data';

/// Stores basic user data including:
/// username - a [String] storing the name of the user's account.
/// profileImageBytes - a raw byte list representation of the user's profile picture. Can be null.
/// ownedBookIds - a [List] of all the ids of books owned by the user. Can be null.
class User {

  final String username;
  final Uint8List? profileImageBytes;
  final List<String>? ownedBookIds;

  User({
    required this.username,
    this.profileImageBytes,
    this.ownedBookIds,
  });

  User.example() : username = 'User', profileImageBytes = null, ownedBookIds = null;

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