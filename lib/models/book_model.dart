class BoocksModel {
  final int numFound;
  final int start;
  final bool numFoundExact;
  final List<Doc> docs;
  final int boocksModelNumFound;
  final String q;
  final dynamic offset;

  BoocksModel({
    required this.numFound,
    required this.start,
    required this.numFoundExact,
    required this.docs,
    required this.boocksModelNumFound,
    required this.q,
    required this.offset,
  });

  factory BoocksModel.fromJson(Map<String, dynamic> json) => BoocksModel(
        numFound: json["numFound"] ?? 0,
        start: json["start"] ?? 0,
        numFoundExact: json["numFoundExact"] ?? false,
        docs: json["docs"] != null
            ? List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x)))
            : [], 
        boocksModelNumFound: json["num_found"] ?? 0,
        q: json["q"] ?? '',
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "numFound": numFound,
        "start": start,
        "numFoundExact": numFoundExact,
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
        "num_found": boocksModelNumFound,
        "q": q,
        "offset": offset,
      };
}

class Doc {
  final List<String> authorKey;
  final List<String> authorName;
  final int firstPublishYear;
  final String key;
  final String title;
  final int coverI;
  final String firstSentence;

  Doc(
      {required this.authorKey,
      required this.authorName,
      required this.firstPublishYear,
      required this.key,
      required this.title,
      required this.coverI,
      required this.firstSentence});

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
      authorKey: json["author_key"] != null
          ? List<String>.from(json["author_key"].map((x) => x))
          : [], 
      authorName: json["author_name"] != null
          ? List<String>.from(json["author_name"].map((x) => x))
          : [], 
      firstPublishYear: json["first_publish_year"] ?? 0,
      key: json["key"] ?? '',
      title: json["title"] ?? '',
      coverI: json["cover_i"] ?? 0,
      firstSentence:  (json["first_sentence"] ?? '')
            .toString()
            .isNotEmpty
            ? json["first_sentence"].toString().replaceAll('[', '').replaceAll(']', '')
            : 'Id Lorem in et pariatur consectetur quis deserunt et ut pariatur. Duis cillum quis Lorem eiusmod velit excepteur ea excepteur magna pariatur Lorem eiusmod cillum exercitation. In nisi cillum esse aliqua quis.Magna occaecat ipsum proident dolor reprehenderit. Nisi qui ad deserunt non nisi exercitation voluptate sit ea sunt laborum esse et. Aliqua velit consectetur dolore nostrud id ullamco officia excepteur nisi amet dolor est magna.Consectetur Lorem mollit ut nostrud. Nulla elit aliquip labore esse laboris mollit occaecat labore magna sit elit ex elit reprehenderit. Aliqua enim amet aliqua consectetur. Veniam Lorem nostrud ut et proident duis sit occaecat deserunt aliqua ad sint ipsum ullamco. Minim laborum qui culpa labore minim culpa cupidatat ea amet qui.',
      );
  Map<String, dynamic> toJson() => {
        "author_key": List<dynamic>.from(authorKey.map((x) => x)),
        "author_name": List<dynamic>.from(authorName.map((x) => x)),
        "first_publish_year": firstPublishYear,
        "key": key,
        "title": title,
      };
}
