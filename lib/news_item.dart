class NewsItem {
  final String title;
  final String startYear;

  NewsItem({required this.title, required this.startYear});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'] ?? 'No Title',
      startYear: json['start_year'] != null ? json['start_year'].toString() : 'No Start Year',
    );
  }
}
