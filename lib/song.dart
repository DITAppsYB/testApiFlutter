import 'package:json_annotation/json_annotation.dart';

part 'song.g.dart';

@JsonSerializable()
class Song {
  @JsonKey(name: 'song_name')
  final String? songName;
  final String? artist;
  @JsonKey(name: 'song_link')
  final String? songLink;
  final String? image;

  Song({
    this.songName,
    this.artist,
    this.songLink,
    this.image,
  });

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
  Map<String, dynamic> toJson() => _$SongToJson(this);
}
