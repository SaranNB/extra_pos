class ItemsResponse {
  List<Item>? data;
  int? totalRecords;
  int? start;
  int? limit;
  String? message;
  bool? success;

  ItemsResponse(
      {this.data,
        this.totalRecords,
        this.start,
        this.limit,
        this.message,
        this.success});

  ItemsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Item>();
      json['data'].forEach((v) {
        data!.add(new Item.fromJson(v));
      });
    }
    totalRecords = json['totalRecords'];
    start = json['start'];
    limit = json['limit'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalRecords'] = this.totalRecords;
    data['start'] = this.start;
    data['limit'] = this.limit;
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Item {
  int? branchId;
  int? itemId;
  String? itemNumber;
  String? itemDescription;
  String? barCode;
  String? itemSaleUom;
  String? itemBuyUom;
  String? itemSkuUom;
  int? vendorBranchId;
  double? stockOnHand;
  double? noOfWeeksStock;
  double? onOrderQuantity;

  Item(
      {this.branchId,
        this.itemId,
        this.itemNumber,
        this.itemDescription,
        this.itemSaleUom,
        this.itemBuyUom,
        this.itemSkuUom,
        this.vendorBranchId,
        this.stockOnHand,
        this.noOfWeeksStock,
        this.onOrderQuantity});

  Item.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    itemId = json['itemId'];
    itemNumber = json['itemNumber'];
    itemDescription = json['itemDescription'];
    barCode = json['barCode'];
    itemSaleUom = json['itemSaleUom'];
    itemBuyUom = json['itemBuyUom'];
    itemSkuUom = json['itemSkuUom'];
    vendorBranchId = json['vendorBranchId'];
    stockOnHand = json['stockOnHand'];
    noOfWeeksStock = json['noOfWeeksStock'];
    onOrderQuantity = json['onOrderQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['itemId'] = this.itemId;
    data['itemNumber'] = this.itemNumber;
    data['itemDescription'] = this.itemDescription;
    data['itemSaleUom'] = this.itemSaleUom;
    data['itemBuyUom'] = this.itemBuyUom;
    data['itemSkuUom'] = this.itemSkuUom;
    data['vendorBranchId'] = this.vendorBranchId;
    data['stockOnHand'] = this.stockOnHand;
    data['noOfWeeksStock'] = this.noOfWeeksStock;
    data['onOrderQuantity'] = this.onOrderQuantity;
    return data;
  }
}