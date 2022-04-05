class inquiry_model{

  //attributes
  String? name;
  String? email;
  String? contactNo;
  String? inquiryDesc;


  inquiry_model({
    this.name,
    this.email,
    this.contactNo,
    this.inquiryDesc,

  });

  //send data to the cloud firestore
  Map<String, dynamic> toMap(){
    return{
      'name': name,
      'email': email,
      'contactNo': contactNo,
      'inquiryDesc': inquiryDesc,

    };
  }

  //retrieve data from the server
  inquiry_model.fromSnapshot(snapshot):
        name = snapshot.data()['name'],
        email = snapshot.data()['email'],
        contactNo = snapshot.data()['contactNo'],
        inquiryDesc = snapshot.data()['inquiryDesc'];

}