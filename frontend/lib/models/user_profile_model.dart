class UserProfileModel {
  Data? data;

  UserProfileModel({this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  GetUser? getUser;

  Data({this.getUser});

  Data.fromJson(Map<String, dynamic> json) {
    getUser =
        json['getUser'] != null ? new GetUser.fromJson(json['getUser']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getUser != null) {
      data['getUser'] = this.getUser!.toJson();
    }
    return data;
  }
}

class GetUser {
  String? createdAt;
  String? username;
  String? email;
  List<Followers>? followers;
  List<Followers>? following;
  List<Posts>? posts;

  GetUser(
      {this.createdAt,
      this.username,
      this.email,
      this.followers,
      this.following,
      this.posts});

  GetUser.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    username = json['username'];
    email = json['email'];
    if (json['followers'] != null) {
      followers = <Followers>[];
      json['followers'].forEach((v) {
        followers!.add(new Followers.fromJson(v));
      });
    }
    if (json['following'] != null) {
      following = <Followers>[];
      json['following'].forEach((v) {
        following!.add(new Followers.fromJson(v));
      });
    }
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    if (this.following != null) {
      data['following'] = this.following!.map((v) => v.toJson()).toList();
    }
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Followers {
  String? email;
  String? username;

  Followers({this.email, this.username});

  Followers.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    return data;
  }
}

class Posts {
  String? body;
  String? type;
  String? createdAt;
  String? username;
  String? sId;

  Posts({this.body, this.type, this.createdAt, this.username, this.sId});

  Posts.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    type = json['type'];
    createdAt = json['createdAt'];
    username = json['username'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['username'] = this.username;
    data['_id'] = this.sId;
    return data;
  }
}
