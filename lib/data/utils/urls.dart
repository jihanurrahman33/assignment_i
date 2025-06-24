class Urls {
  static const _baseUrl = 'https://www.pqstec.com/InvoiceApps/Values';
  static const imageBaseLink = "https://www.pqstec.com/InvoiceApps";

  static login({required String userName, required String password}) =>
      '$_baseUrl/LogIn?UserName=$userName&Password=$password&ComId=1';
  static getCustomerList({required int pageNo}) =>
      '$_baseUrl/GetCustomerList?searchquery&pageNo=$pageNo&pageSize=20&SortyBy=Balance';
}
