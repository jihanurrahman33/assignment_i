class CustomerListModel {
  int? success;
  bool? error;
  List<CustomerList>? customerList;
  PageInfo? pageInfo;

  CustomerListModel({
    this.success,
    this.error,
    this.customerList,
    this.pageInfo,
  });

  CustomerListModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    error = json['error'];
    if (json['CustomerList'] != null) {
      customerList = <CustomerList>[];
      json['CustomerList'].forEach((v) {
        customerList!.add(CustomerList.fromJson(v));
      });
    }
    pageInfo =
        json['PageInfo'] != null ? PageInfo.fromJson(json['PageInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['error'] = this.error;
    if (this.customerList != null) {
      data['CustomerList'] = this.customerList!.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    return data;
  }
}

class CustomerList {
  int? id;
  String? name;
  String? email;
  String? primaryAddress;
  String? secoundaryAddress;
  String? notes;
  String? phone;
  String? custType;
  String? parentCustomer;
  String? imagePath;
  double? totalDue;
  String? lastSalesDate;
  String? lastInvoiceNo;
  String? lastSoldProduct;
  double? totalSalesValue;
  double? totalSalesReturnValue;
  double? totalAmountBack;
  double? totalCollection;
  String? lastTransactionDate;
  Null clinetCompanyName;

  CustomerList({
    this.id,
    this.name,
    this.email,
    this.primaryAddress,
    this.secoundaryAddress,
    this.notes,
    this.phone,
    this.custType,
    this.parentCustomer,
    this.imagePath,
    this.totalDue,
    this.lastSalesDate,
    this.lastInvoiceNo,
    this.lastSoldProduct,
    this.totalSalesValue,
    this.totalSalesReturnValue,
    this.totalAmountBack,
    this.totalCollection,
    this.lastTransactionDate,
    this.clinetCompanyName,
  });

  CustomerList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    email = json['Email'];
    primaryAddress = json['PrimaryAddress'];
    secoundaryAddress = json['SecoundaryAddress'];
    notes = json['Notes'];
    phone = json['Phone'];
    custType = json['CustType'];
    parentCustomer = json['ParentCustomer'];
    imagePath = json['ImagePath'];
    totalDue = json['TotalDue'];
    lastSalesDate = json['LastSalesDate'];
    lastInvoiceNo = json['LastInvoiceNo'];
    lastSoldProduct = json['LastSoldProduct'];
    totalSalesValue = json['TotalSalesValue'];
    totalSalesReturnValue = json['TotalSalesReturnValue'];
    totalAmountBack = json['TotalAmountBack'];
    totalCollection = json['TotalCollection'];
    lastTransactionDate = json['LastTransactionDate'];
    clinetCompanyName = json['ClinetCompanyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['PrimaryAddress'] = this.primaryAddress;
    data['SecoundaryAddress'] = this.secoundaryAddress;
    data['Notes'] = this.notes;
    data['Phone'] = this.phone;
    data['CustType'] = this.custType;
    data['ParentCustomer'] = this.parentCustomer;
    data['ImagePath'] = this.imagePath;
    data['TotalDue'] = this.totalDue;
    data['LastSalesDate'] = this.lastSalesDate;
    data['LastInvoiceNo'] = this.lastInvoiceNo;
    data['LastSoldProduct'] = this.lastSoldProduct;
    data['TotalSalesValue'] = this.totalSalesValue;
    data['TotalSalesReturnValue'] = this.totalSalesReturnValue;
    data['TotalAmountBack'] = this.totalAmountBack;
    data['TotalCollection'] = this.totalCollection;
    data['LastTransactionDate'] = this.lastTransactionDate;
    data['ClinetCompanyName'] = this.clinetCompanyName;
    return data;
  }
}

class PageInfo {
  int? pageNo;
  int? pageSize;
  int? pageCount;
  int? totalRecordCount;

  PageInfo({this.pageNo, this.pageSize, this.pageCount, this.totalRecordCount});

  PageInfo.fromJson(Map<String, dynamic> json) {
    pageNo = json['PageNo'];
    pageSize = json['PageSize'];
    pageCount = json['PageCount'];
    totalRecordCount = json['TotalRecordCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PageNo'] = this.pageNo;
    data['PageSize'] = this.pageSize;
    data['PageCount'] = this.pageCount;
    data['TotalRecordCount'] = this.totalRecordCount;
    return data;
  }
}
