class Post {
  final String id;
  final String type;
  final String body;
  final User user;
  final String username;
  final String createdAt;

  Post({
    required this.id,
    required this.type,
    required this.body,
    required this.user,
    required this.username,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      type: json['type'],
      body: json['body'],
      user: User.fromJson(json['user']),
      username: json['username'],
      createdAt: json['createdAt'],
    );
  }
}

class User {
  final String id;
  // final String username;
  // final String email;
  // final String createdAt;

  User({
    required this.id,
    // required this.username,
    // required this.email,
    // required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      // username: json['username'],
      // email: json['email'],
      // createdAt: json['createdAt'],
    );
  }
}

class Query {
  final List<Post> posts;

  Query({required this.posts});

  factory Query.fromJson(Map<String, dynamic> json) {
    return Query(
      posts: List<Post>.from(
          json['getPosts'].map((post) => Post.fromJson(post)).toList()),
    );
  }
}
