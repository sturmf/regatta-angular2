import 'package:dson/dson.dart';


@serializable
class Person {
  final int id;
  final String url;
  @SerializedName("first_name")
  String firstName;
  @SerializedName("last_name")
  String lastName;
  @SerializedName("sailing_club")
  String sailingClub;


  Person(this.id, this.url, [this.firstName, this.lastName, this.sailingClub]);

  String get fullName => '$firstName $lastName';
}
