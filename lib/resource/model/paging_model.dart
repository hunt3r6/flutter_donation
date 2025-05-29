import 'dart:convert';

class PagingModel<T> {
  final int? currentPage;
  final List<T>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  PagingModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory PagingModel.fromJson(
    String str,
    T Function(Map<String, dynamic>) fromMapT,
  ) => PagingModel.fromMap(json.decode(str), fromMapT);

  String toJson(Map<String, dynamic> Function(T) toMapT) =>
      json.encode(toMap(toMapT));

  factory PagingModel.fromMap(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromMapT,
  ) => PagingModel(
    currentPage: json["current_page"],
    data:
        json["data"] == null
            ? []
            : List<T>.from(json["data"].map((x) => fromMapT(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap(Map<String, dynamic> Function(T) toMapT) => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => toMapT(x))),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}
