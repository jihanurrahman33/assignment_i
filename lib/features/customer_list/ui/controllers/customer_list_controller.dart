import 'package:assignment/data/models/customer_list_model.dart';
import 'package:assignment/data/services/network_client.dart';
import 'package:assignment/data/utils/urls.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerListController extends GetxController {
  List<CustomerList>? customerList = [];
  PageInfo? pageInfo;

  int currentPage = 1;

  bool _customerDataInProgress = false;
  bool get customerDataInProgress => _customerDataInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get hasMorePages => currentPage < (pageInfo?.pageCount ?? 1);

  Future<bool> getCustomerListData({
    required int pageNumber,
    bool append = false,
  }) async {
    final loginToken = await getLoginToken();
    bool isSuccess = false;

    _customerDataInProgress = true;
    update();

    final headers = {'Authorization': loginToken ?? ''};

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.getCustomerList(pageNo: pageNumber),
      headers: headers,
    );

    if (response.isSucess) {
      final customerListModel = CustomerListModel.fromJson(response.data!);
      final fetchedList = customerListModel.customerList ?? [];

      if (append && customerList != null) {
        customerList!.addAll(fetchedList);
      } else {
        customerList = fetchedList;
      }

      pageInfo = customerListModel.pageInfo;
      currentPage = pageNumber;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _customerDataInProgress = false;
    update();
    return isSuccess;
  }

  Future<String?> getLoginToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
