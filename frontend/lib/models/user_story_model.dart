class UserStoryModel {
  String? name;
  String? profilepic;
  bool? storyuploaded;
  bool? storyviewed;

  UserStoryModel(
      {this.name, this.profilepic, this.storyuploaded, this.storyviewed});

  UserStoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilepic = json['profilepic'];
    storyuploaded = json['storyuploaded'];
    storyviewed = json['storyviewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profilepic'] = this.profilepic;
    data['storyuploaded'] = this.storyuploaded;
    data['storyviewed'] = this.storyviewed;
    return data;
  }
}
