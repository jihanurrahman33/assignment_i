import 'package:assignment/data/models/customer_list_model.dart';
import 'package:assignment/data/services/network_client.dart';
import 'package:assignment/data/utils/urls.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerListController extends GetxController {
  List<CustomerList>? customerList = [];
  PageInfo? pageInfo;

  bool _customerDataInProgress = false;
  bool get custoemrDataInProgress => _customerDataInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int currentPage = 1;

  Future<bool> getCustomerListData({required int pageNumber}) async {
    final loginToken = await getLoginToken();
    bool isSuccess = false;
    _customerDataInProgress = true;
    update();

    Map<String, String> headers = {'Authorization': loginToken ?? ''};

    NetworkResponse response = await NetworkClient.getRequest(
      url: "${Urls.getCustomerList(pageNo: pageNumber)}",
      headers: headers,
    );

    if (response.isSucess) {
      final customerListModel = CustomerListModel.fromJson(response.data!);
      customerList = customerListModel.customerList;
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
