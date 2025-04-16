import 'package:beauty_salon/view/user_view/cart_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../res/components/snackbar.dart';

class CartProvider with ChangeNotifier {
  // int _quantity = 01;
  List<Map<String, dynamic>> _itemsList = [];

  List<Map<String, dynamic>> get itemsList => _itemsList;

  // int get quantity=> _quantity;

  int _cartLength = 0;

  int get cartLength => _cartLength;

  bool _isPresent = false;
  bool get isPresent => _isPresent;

  void addItem(value) {
    if (value != null) {
      _itemsList.add(value);
      print(_itemsList);
      notifyListeners();
    } else {
      print('Value is null');
    }
  }

  void removeItem(value) {
    if (value != null) {
      _itemsList.remove(value);
      print(_itemsList);
      notifyListeners();
    } else {
      print('Value is null');
    }
  }

  // Future<void> addToCart (String catId, String docId, BuildContext context) async{
  //   final cart = FirebaseFirestore.instance.collection('cart');
  //   final serviceRef = FirebaseFirestore.instance.collection('services').doc(catId).collection('subServices').doc(docId);
  //   final querySnapshot = await cart.where('serviceRef', isEqualTo: serviceRef).get();
  //  if(querySnapshot.docs.isNotEmpty){
  //    Utils().cartSnackBar(context, 'Service Already In Cart', 'View', (){});
  //  }
  //  else {
  //    await cart.add({
  //      'serviceRef' : serviceRef,
  //      'user_id' : FirebaseAuth.instance.currentUser!.uid,
  //    });
  //    Utils().cartSnackBar(context, 'Service Added To Cart', 'View', (){});
  //  }
  //
  // }

  Future<void> addToCart(String serviceName, String servicePrice,
       String serviceImageUrl, BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    var price = int.tryParse(servicePrice);
    final cartItem = await FirebaseFirestore.instance.collection('cart').where('user_id', isEqualTo: user!.uid)
        .where('service_name', isEqualTo: serviceName).get();
    if (cartItem.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('cart').doc().set({
        'service_name': serviceName,
        'service_price': price,
        'service_image_url': serviceImageUrl,
        'service_added_at': DateTime.now(),
        'user_id': user.uid,
      }).then((value) {
        getLength();
        _isPresent = true;
        notifyListeners();
        Utils().cartSnackBar(context, 'Service Added To Cart', 'View Cart', () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartScreen()));
        });
      });
    }
    else {
      getLength();
  //    notifyListeners();
      Utils().cartSnackBar(context, 'Service Already In Cart', 'View Cart', () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CartScreen()));
      });
    }
  }

  Stream<QuerySnapshot> fetchCartItems() {
    User? user = FirebaseAuth.instance.currentUser;
    return  FirebaseFirestore.instance.collection('cart').where('user_id', isEqualTo:user!.uid ).snapshots();
  }
    // Stream<List<Map<String, dynamic>>> fetchCartItems() {
    //   final cart = FirebaseFirestore.instance.collection('cart');
    //   User? user = FirebaseAuth.instance.currentUser;
    //
    //   return cart
    //       .where('user_id', isEqualTo: user!.uid)
    //       .snapshots()
    //       .asyncMap((snapshot) async {
    //     _cartLength = snapshot.docs.length;
    //     notifyListeners();
    //     return Future.wait(snapshot.docs.map((doc) async {
    //       final serviceRef = doc['serviceRef'] as DocumentReference;
    //       final serviceSnapshot = await serviceRef.get();
    //
    //       return {
    //         'docId': doc.id,
    //         'service_name': serviceSnapshot['service_name'],
    //         'service_price': serviceSnapshot['service_price'],
    //         'service_description': serviceSnapshot['service_description'],
    //         'image_url': serviceSnapshot['image_url'],
    //       };
    //     }).toList());
    //   });
    // }

  void removeFromCart(String docId, BuildContext context)async{
await FirebaseFirestore.instance.collection('cart').doc(docId).delete();
getLength();

//notifyListeners();
  }

void getLength() async{
  User? user = FirebaseAuth.instance.currentUser;
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('cart').where('user_id', isEqualTo: user!.uid ).get();
  _cartLength = snapshot.docs.length;
  notifyListeners();
}



  void fetchAndDeleteExpiredItems() async {
    getLength();
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('cart').get();
    DateTime now = DateTime.now();
    for (var doc in snapshot.docs) {
      Timestamp createdAt = doc['service_added_at'] as Timestamp;
      DateTime itemTime = createdAt.toDate();
      if (now.difference(itemTime).inHours >= 24) {
        await doc.reference.delete();

      // notifyListeners();

      }
    }
  }


// Future<void> removeFromCart(String docId) async {
    //   final cart = FirebaseFirestore.instance.collection('cart');
    //   await cart.doc(docId).delete();
    // }

    // void incrementQuantity(){
    //   _quantity++;
    //   notifyListeners();
    // }
    //
    // void decrementQuantity(){
    //   if(_quantity>1){
    //     _quantity--;
    //     notifyListeners();
    //   }
    //
    // }

}
