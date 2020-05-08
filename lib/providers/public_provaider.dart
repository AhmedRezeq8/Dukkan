import 'package:flutter/material.dart';
import 'package:shop/Services/api_service.dart';

class PublicProvider with ChangeNotifier {
  int cartCount = 0;
  // print('ccc' + cartCount.toString());
  int get index {
    ApiService().getCartItem(2, 1).then((onValue) {
      try {
        cartCount = onValue['total'] == null ? 0 : onValue['total'];
      } catch (e) {
        cartCount = 0;
        print(e.toString());
      }
      notifyListeners();
    });
    return cartCount;
  }

  set index(int val) {
    cartCount = val;
    notifyListeners();
  }

  int getCartCount(int userId) {
    int _cartCount = 0;
    ApiService().getCartItem(2, 1).then((onValue) {
      _cartCount = onValue['total'];
    });
    return _cartCount;
  }
}

// class SelectedDomainProvider with ChangeNotifier {
//   int selectedDomainId = 1;
//   int get index => selectedDomainId;

//   set index(int val) {
//     selectedDomainId = val;
//     notifyListeners();
//   }
// }

// class SelectedSginProvider with ChangeNotifier {
//   int selectedSign = 1;
//   int get index => selectedSign;

//   set index(int val) {
//     selectedSign = val;
//     notifyListeners();
//   }
// }

// // home main select video status listener
// class SelectedVideoStatusProvider with ChangeNotifier {
//   int selectedStatus = 1;
//   int get index => selectedStatus;

//   set index(int val) {
//     selectedStatus = val;
//     notifyListeners();
//   }
// }
