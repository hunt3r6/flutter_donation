// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SliderModel {
  final int? id;
  final String? image;
  SliderModel({this.id, this.image});

  SliderModel copyWith({int? id, String? image}) {
    return SliderModel(id: id ?? this.id, image: image ?? this.image);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'image': image};
  }

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id'] != null ? map['id'] as int : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SliderModel.fromJson(String source) =>
      SliderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SliderModel(id: $id, image: $image)';

  @override
  bool operator ==(covariant SliderModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ image.hashCode;
}
