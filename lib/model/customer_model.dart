class CustomerModel {
  final String contactFirstName;
  final String contactLastName;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String zipCode;
  final String phoneNumber;

  CustomerModel(
      {this.contactFirstName,
      this.contactLastName,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.state,
      this.zipCode,
      this.phoneNumber});

  CustomerModel.fromJson(Map<String, dynamic> json)
      : contactFirstName = json['contactFirstName'],
        contactLastName = json['contactLastName'],
        addressLine1 = json['addressLine1'],
        addressLine2 = json['addressLine2'],
        city = json['city'],
        state = json['state'],
        zipCode = json['zipCode'],
        phoneNumber = json['phoneNumber'];

  Map<String, dynamic> toJson() => {
        'contactFirstName': contactFirstName,
        'contactLastName': contactLastName,
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'phoneNumber': phoneNumber
      };
}
