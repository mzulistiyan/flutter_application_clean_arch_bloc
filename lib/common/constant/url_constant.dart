class UrlConstant {
  static const String baseUrl = 'https://sedt.braga.co.id/panel';

  static const String login = '/auth/login';
  static const String userMe = '/users/me';
  static const String bookRecomendation = '/stats/book_recomendations';
  static const String booList = '/items/book';
  static const String bookTop10 = '/stats/book_top_10';

  static const String booDetail = '/items/book/';
  static const String readingList = '/items/reading_progress?meta=*&fields=*,book_id.*,book_id.book_category_id.id,book_id.book_category_id.name&sort=-date_updated';

  static const String reading = '/items/reading_progress';

  static const String bookmark = '/items/bookmark';

  static const String profile = '/items/user_profile';
  static const String major = '/items/major';

  // analytic
  static const String readingHistoryBook = '/items/reading_history_book';
  static const String readingHistoryTime = '/items/reading_history_time';

  // search
  static const String search = '/services/book_search';
  static const String searchPopular = '/stats/book_search_popular';

  // book category
  static const String bookCategory = '/items/book_category';

  // pdf viewer UBC
  static const String pdfViewerUBC = 'https://open.library.ubc.ca/viewer/:collection/:id';
  static const String pdfDownloadUBC = 'https://open.library.ubc.ca/media/download/pdf/:collection/:id';

  // pdf download UML
  static const String pdfDownloadUML = 'https://deepblue.lib.umich.edu/data/downloads/:fileset_id.json';

  // get html Oxford
  static const String urlOxford = 'https://ora.ox.ac.uk/objects/:uuid';
}
