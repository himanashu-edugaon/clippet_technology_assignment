// To parse this JSON data, do
//
//     final movieItem = movieItemFromJson(jsonString);

import 'dart:convert';

List<MovieItem> movieItemFromJson(String str) => List<MovieItem>.from(json.decode(str).map((x) => MovieItem.fromJson(x)));

String movieItemToJson(List<MovieItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MovieItem {
  String? id;
  String? description;
  List<String>? director;
  List<String>? writers;
  List<String>? stars;
  List<String>? productionCompany;
  int? pageViews;
  List<String>? upVoted;
  List<String>? downVoted;
  String? title;
  String? language;
  dynamic runTime;
  int? releasedDate;
  String? genre;
  List<Voted>? voted;
  String? poster;
  int? totalVoted;
  int? voting;

  MovieItem({
    this.id,
    this.description,
    this.director,
    this.writers,
    this.stars,
    this.productionCompany,
    this.pageViews,
    this.upVoted,
    this.downVoted,
    this.title,
    this.language,
    this.runTime,
    this.releasedDate,
    this.genre,
    this.voted,
    this.poster,
    this.totalVoted,
    this.voting,
  });

  factory MovieItem.fromJson(Map<String, dynamic> json) => MovieItem(
    id: json["_id"],
    description: json["description"],
    director: json["director"] == null ? [] : List<String>.from(json["director"]!.map((x) => x)),
    writers: json["writers"] == null ? [] : List<String>.from(json["writers"]!.map((x) => x)),
    stars: json["stars"] == null ? [] : List<String>.from(json["stars"]!.map((x) => x)),
    productionCompany: json["productionCompany"] == null ? [] : List<String>.from(json["productionCompany"]!.map((x) => x)),
    pageViews: json["pageViews"],
    upVoted: json["upVoted"] == null ? [] : List<String>.from(json["upVoted"]!.map((x) => x)),
    downVoted: json["downVoted"] == null ? [] : List<String>.from(json["downVoted"]!.map((x) => x)),
    title: json["title"],
    language: json["language"],
    runTime: json["runTime"],
    releasedDate: json["releasedDate"],
    genre: json["genre"],
    voted: json["voted"] == null ? [] : List<Voted>.from(json["voted"]!.map((x) => Voted.fromJson(x))),
    poster: json["poster"],
    totalVoted: json["totalVoted"],
    voting: json["voting"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description,
    "director": director == null ? [] : List<dynamic>.from(director!.map((x) => x)),
    "writers": writers == null ? [] : List<dynamic>.from(writers!.map((x) => x)),
    "stars": stars == null ? [] : List<dynamic>.from(stars!.map((x) => x)),
    "productionCompany": productionCompany == null ? [] : List<dynamic>.from(productionCompany!.map((x) => x)),
    "pageViews": pageViews,
    "upVoted": upVoted == null ? [] : List<dynamic>.from(upVoted!.map((x) => x)),
    "downVoted": downVoted == null ? [] : List<dynamic>.from(downVoted!.map((x) => x)),
    "title": title,
    "language": language,
    "runTime": runTime,
    "releasedDate": releasedDate,
    "genre": genre,
    "voted": voted == null ? [] : List<dynamic>.from(voted!.map((x) => x.toJson())),
    "poster": poster,
    "totalVoted": totalVoted,
    "voting": voting,
  };
}

class Voted {
  List<dynamic>? upVoted;
  List<dynamic>? downVoted;
  String? id;
  int? updatedAt;
  String? genre;

  Voted({
    this.upVoted,
    this.downVoted,
    this.id,
    this.updatedAt,
    this.genre,
  });

  factory Voted.fromJson(Map<String, dynamic> json) => Voted(
    upVoted: json["upVoted"] == null ? [] : List<dynamic>.from(json["upVoted"]!.map((x) => x)),
    downVoted: json["downVoted"] == null ? [] : List<dynamic>.from(json["downVoted"]!.map((x) => x)),
    id: json["_id"],
    updatedAt: json["updatedAt"],
    genre: json["genre"],
  );

  Map<String, dynamic> toJson() => {
    "upVoted": upVoted == null ? [] : List<dynamic>.from(upVoted!.map((x) => x)),
    "downVoted": downVoted == null ? [] : List<dynamic>.from(downVoted!.map((x) => x)),
    "_id": id,
    "updatedAt": updatedAt,
    "genre": genre,
  };
}
