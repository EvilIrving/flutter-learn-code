class BannerListData {
  List<BannerItemData?>? bannerList;

  BannerListData.fromJson(dynamic json) {
    bannerList = [];
    for (var item in json) {
      bannerList?.add(BannerItemData.fromJson(item));
    }
  }
}

class BannerItemData {
  String? desc;
  int? id;
  String? imagePath;
  int? isVisible;
  int? order;
  String? title;
  int? type;
  String? url;

  BannerItemData(
      {this.desc,
      this.id,
      this.imagePath,
      this.isVisible,
      this.order,
      this.title,
      this.type,
      this.url});

  BannerItemData.fromJson(Map<String, dynamic> json) {
    if (json["desc"] is String) {
      desc = json["desc"];
    }
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["imagePath"] is String) {
      imagePath = json["imagePath"];
    }
    if (json["isVisible"] is int) {
      isVisible = json["isVisible"];
    }
    if (json["order"] is int) {
      order = json["order"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["type"] is int) {
      type = json["type"];
    }
    if (json["url"] is String) {
      url = json["url"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["desc"] = desc;
    data["id"] = id;
    data["imagePath"] = imagePath;
    data["isVisible"] = isVisible;
    data["order"] = order;
    data["title"] = title;
    data["type"] = type;
    data["url"] = url;
    return data;
  }
}
