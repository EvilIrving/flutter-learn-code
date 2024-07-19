class HotWebModel {
  List<HotWebItem>? data;

  HotWebModel({
    this.data,
  });

  HotWebModel.fromJson(List<dynamic>? json) {
    if (json is List) {
      data = json.map((e) => HotWebItem.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class HotWebItem {
  String? category;
  String? icon;
  int? id;
  String? link;
  String? name;
  int? order;
  int? visible;

  HotWebItem(
      {this.category,
      this.icon,
      this.id,
      this.link,
      this.name,
      this.order,
      this.visible});

  HotWebItem.fromJson(Map<String, dynamic> json) {
    if (json["category"] is String) {
      category = json["category"];
    }
    if (json["icon"] is String) {
      icon = json["icon"];
    }
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["link"] is String) {
      link = json["link"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["order"] is int) {
      order = json["order"];
    }
    if (json["visible"] is int) {
      visible = json["visible"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["category"] = category;
    _data["icon"] = icon;
    _data["id"] = id;
    _data["link"] = link;
    _data["name"] = name;
    _data["order"] = order;
    _data["visible"] = visible;
    return _data;
  }
}

class HotKeyModel {
  List<HotKeyItem>? data;

  HotKeyModel({
    this.data,
  });

  HotKeyModel.fromJson(List<dynamic>? json) {
    if (json is List) {
      data = json.map((e) => HotKeyItem.fromJson(e)).toList();
    }
  }
}

class HotKeyItem {
  int? id;
  String? link;
  String? name;
  int? order;
  int? visible;

  HotKeyItem({this.id, this.link, this.name, this.order, this.visible});

  HotKeyItem.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["link"] is String) {
      link = json["link"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["order"] is int) {
      order = json["order"];
    }
    if (json["visible"] is int) {
      visible = json["visible"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["link"] = link;
    _data["name"] = name;
    _data["order"] = order;
    _data["visible"] = visible;
    return _data;
  }
}
