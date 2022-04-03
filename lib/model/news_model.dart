class news_model{
  //attributes
  String? title;
  String? image;
  String? description;


  //constructor
news_model({
    this.title,
    this.image,
    this.description
});

//send data to the cloud firestore
Map<String, dynamic> toMap(){
  return{
    'title' : title,
    'image' : image,
    'description' : description,
  };
}
}