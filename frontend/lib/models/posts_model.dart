// class Post {
//   final String id;
//   final String type;
//   final String body;
//   final User user;
//   final String username;
//   final String createdAt;

//   Post({
//     required this.id,
//     required this.type,
//     required this.body,
//     required this.user,
//     required this.username,
//     required this.createdAt,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['_id'],
//       type: json['type'],
//       body: json['body'],
//       user: User.fromJson(json['user']),
//       username: json['username'],
//       createdAt: json['createdAt'],
//     );
//   }
// }

// class User {
//   final String id;
//   // final String username;
//   // final String email;
//   // final String createdAt;

//   User({
//     required this.id,
//     // required this.username,
//     // required this.email,
//     // required this.createdAt,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['_id'],
//       // username: json['username'],
//       // email: json['email'],
//       // createdAt: json['createdAt'],
//     );
//   }
// }

// class Query {
//   final List<Post> posts;

//   Query({required this.posts});

//   factory Query.fromJson(Map<String, dynamic> json) {
//     return Query(
//       posts: List<Post>.from(
//           json['getPosts'].map((post) => Post.fromJson(post)).toList()),
//     );
//   }
// }

class Post {
  String? sTypename;
  String? sId;
  String? body;
  String? createdAt;
  List<User>? taggedUsers;
  String? type;
  User? user;

  Post({
    this.sTypename,
    this.sId,
    this.body,
    this.createdAt,
    this.taggedUsers,
    this.type,
    this.user,
  });

  Post.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    sId = json['_id'];
    body = json['body'];
    createdAt = json['createdAt'];
    if (json['taggedUsers'] != null) {
      taggedUsers =
          List<User>.from(json['taggedUsers'].map((x) => User.fromJson(x)));
    }
    type = json['type'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__typename'] = sTypename;
    data['_id'] = sId;
    data['body'] = body;
    data['createdAt'] = createdAt;
    if (taggedUsers != null) {
      data['taggedUsers'] = taggedUsers!.map((x) => x.toJson()).toList();
    }
    data['type'] = type;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? sTypename;
  String? username;
  String? sId;
  String? email;

  User({this.sTypename, this.username, this.sId, this.email});

  User.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    username = json['username'];
    sId = json['_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__typename'] = sTypename;
    data['username'] = username;
    data['_id'] = sId;
    data['email'] = email;
    return data;
  }
}
