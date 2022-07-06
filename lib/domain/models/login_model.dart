class Customer{
  String id ;
  String name;
  int numOfNotification;

  Customer(this.id,this.name,this.numOfNotification);
}


class Contacts{
  String phone;
  String email;
  String link;

  Contacts(this.phone,this.email,this.link);
}

class Authentication{

    Customer? customer;
    Contacts? contacts;

    Authentication(this.contacts,this.customer);
}