class MapStyles {
  String? image;
  String? url;
  String? name;

  MapStyles({this.image, this.url,this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapStyles &&
          runtimeType == other.runtimeType &&
          image == other.image &&
          url == other.url &&
          name == other.name;

  @override
  int get hashCode => image.hashCode ^ url.hashCode ^ name.hashCode;
}