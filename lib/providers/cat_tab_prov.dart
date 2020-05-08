import 'package:flutter/cupertino.dart';

class TabsIndex with ChangeNotifier{

int selectedCategoryId = 0;

void updateCategoryId(int selectedCategoryId)
{
  this.selectedCategoryId = selectedCategoryId;
  notifyListeners();
}





  int _index= 0;
  int get index => _index;

  set index(int val){
    _index= val;
    notifyListeners();
  }

  int _count = 0;
  int get count => _count;

  set count(int val){
    _count= val;
    notifyListeners();
  }
  
}
