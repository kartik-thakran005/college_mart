
class FeedbackForm {

  String _name;
  String _email;
  String _mobileNo;
  String _Product;
  // String _feedback;

  FeedbackForm(this._name, this._mobileNo, this._email, this._Product);

  // Method to make GET parameters.
  String toParams() =>
      "?name=$_name&mobileno=$_mobileNo&email=$_email&product=$_Product";


}