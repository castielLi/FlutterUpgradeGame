class VoucherModel {
  int voucher;

  VoucherModel({this.voucher});

  VoucherModel.fromJson(Map<String, dynamic> json) {
    voucher = json['voucher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voucher'] = this.voucher;
    return data;
  }
}