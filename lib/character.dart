class Character{
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  String image;
  List<String> episode;
  String url;
  String created;

  Character(
      {this.id,
        this.name,
        this.status,
        this.species,
        this.type,
        this.gender,
        this.image,
        this.episode,
        this.url,
        this.created});

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    image = json['image'];
    episode = json['episode'].cast<String>();
    url = json['url'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['species'] = this.species;
    data['type'] = this.type;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['episode'] = this.episode;
    data['url'] = this.url;
    data['created'] = this.created;
    return data;
  }
}