import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyn_zon/login.dart';
import 'package:fyn_zon/mainApi.dart';
import 'package:fyn_zon/mainscreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyn_zon/sale.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fyn_zon/tokenPass.dart';
import './Buy.dart';
class Autogenerated {
  String message;
  String error;
  Data data;

  Autogenerated({this.message, this.error, this.data});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String country;
  String sId;
  int phone;
  String fname;
  String lname;
  String email;
  String pin;
  String address;
  String adhaarNumber;
  String city;
  bool kycApproved;
  String dob;
  String panNumber;
  String pinCode;
  String state;
  String nationality;

  Data(
      {this.country,
        this.sId,
        this.phone,
        this.fname,
        this.lname,
        this.email,
        this.pin,
        this.address,
        this.adhaarNumber,
        this.city,
        this.kycApproved,
        this.dob,
        this.panNumber,
        this.pinCode,
        this.state,
        this.nationality});

  Data.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    sId = json['_id'];
    phone = json['phone'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    pin = json['pin'];
    address = json['address'];
    adhaarNumber = json['adhaarNumber'];
    city = json['city'];
    kycApproved = json['kycApproved'];
    dob = json['dob'];
    panNumber = json['panNumber'];
    pinCode = json['pinCode'];
    state = json['state'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['_id'] = this.sId;
    data['phone'] = this.phone;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['pin'] = this.pin;
    data['address'] = this.address;
    data['adhaarNumber'] = this.adhaarNumber;
    data['kycApproved'] = this.kycApproved;
    data['city'] = this.city;
    data['dob'] = this.dob;
    data['panNumber'] = this.panNumber;
    data['pinCode'] = this.pinCode;
    data['state'] = this.state;
    data['nationality'] = this.nationality;
    return data;
  }
}
class BuySell extends StatefulWidget {
  String base, tread;
  var price;


  BuySell({
    Key key,
    @required this.base,
    @required this.tread,
    @required this.price,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BuySellState();
  }
}

class BuySellState extends State<BuySell> {
  String base, tread;
  var price;
  Autogenerated futureAlbum;
  @override
  void initState() {
    super.initState();
    fetchAlbum1();
    setState(() {

    });
  }
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs?.clear();
    prefs.remove('token');
    prefs.remove('userid');
    Fluttertoast.showToast(
        msg: "User Logout",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1
    );
    setState(() {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          child: MainScreenPage(),
        ),
      );
    });
        (Route route) => false;
  }
  var userid;
  Future<void> fetchAlbum1() async {
    /* var data = {

    };*/
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('userid');
    });
    var apiData = {
      "url": AuthToken.api + "/" + "client/userDetails/"+ prefs.getString('token'),
      //"data": data
    };
    ApiClass.getApiCall(apiData, (onSuccess) {
      print(onSuccess.toString());
      futureAlbum = Autogenerated.fromJson(jsonDecode(onSuccess['response']));
      //print("walletqrcode>>>>>>> " + futureAlbum.data.phone.toString());
      print("walletqrcode>>>>>>> " + futureAlbum.message.toString());

      setState(() {});
    }, (onError) {
      print("Error working with the api");
      logout();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.4,
      child: Padding(
        padding: const EdgeInsets.only(),
        child: new DefaultTabController(
          length: 2,
          child: new Scaffold(
            appBar: new AppBar(
              backgroundColor: Color(0xFF18222C),
              flexibleSpace: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  new TabBar(
                    /* onTap: (int index) {
                      setState(() {
                        _selectedPage = index;
                      });
                    },*/
                    tabs: [
                      new Tab(
                        text: 'BUY',
                      ),
                      new Tab(
                        text: 'SELL',
                      ),
                    ],
                    indicatorColor: Color(0xFF233446),
                    unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
            //body: _pageOptions[_selectedPage],
            body: TabBarView(
              children: [
                BuyPage(base: widget.base, tread: widget.tread, price: widget.price),
                SalePage(base: widget.base, tread: widget.tread, price: widget.price),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
