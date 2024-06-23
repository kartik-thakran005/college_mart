import 'package:hive/hive.dart' ;

class tododatabase{
  List cart=[];
  final _mybox=Hive.box('mybox');
  void createinitialdata(){
    cart=[];
  }
  void loaddata(){
    cart=_mybox.get("CART");
  }
  void updatedatabase(){
    _mybox.put("CART", cart);
  }
}