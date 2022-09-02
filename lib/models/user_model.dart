class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String fullName;
  final List followers;
  final List following;

  const User(
      {required this.email,
      required this.uid,
      required this.photoUrl,
      required this.username,
      required this.fullName,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'photourl': photoUrl,
        'full name': fullName,
        'followers': followers,
        'following': following
      };
}
