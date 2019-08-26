class Contact {
  final String name, email, phone;

  Contact.fromJson(Map<String, dynamic> json)
      : this.name = json['name'],
        this.email = json['email'],
        this.phone = json['phone'];

  // @override
  // String toString() {
  //   print(
  //       "Name : ${this.name} , email : ${this.email} , phone : ${this.phone}");
  //   return super.toString();
  // }
}
