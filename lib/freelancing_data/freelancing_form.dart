//   this form is fot DTU


class freelancing_form{

  String _name;
  String _rollNo;
  String _mobileNo;
  String _Product;
  // String _feedback;

  freelancing_form(this._name, this._mobileNo, this._rollNo, this._Product);

  // Method to make GET parameters.
  String toParams() =>
      "?name=$_name&mobileno=$_mobileNo&rollno=$_rollNo&product=$_Product";


}