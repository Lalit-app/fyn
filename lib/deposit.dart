import 'dart:convert';
import 'package:fyn_zon/login.dart';
import 'package:fyn_zon/mainscreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fyn_zon/instantDeposit.dart';
import 'package:fyn_zon/tokenPass.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'KYC/common_api.dart';
import 'Model/wallet_model.dart';
import 'custom_appbar.dart';
import 'mainApi.dart';
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
class DepositPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DepositPageState();
  }
}

class DepositPageState extends State<DepositPage> {
  AutogeneratedWallet futureAlbum;
  var userid1;
  @override
  void initState() {
    fetchAlbum();
    //fetchAlbum1();
    super.initState();

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

  fetchAlbum() async {
    /* var data = {

    };*/
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid1 = prefs.getString("userid");
    });
    var apiData = {
      "url": AuthToken.api +
          "/" +
          "getBalance/" +
          prefs.getString('token') +
          "/" +
          prefs.getString('userid'),
      //"data": data
    };
    ApiClass.getApiCall(apiData, (onSuccess) {
      print(onSuccess.toString());
      futureAlbum = AutogeneratedWallet.fromJson(jsonDecode(onSuccess['response']));
      print("wallet>>>>>>> " + futureAlbum.data.iNRBalance.toString());
      setState(() {});
    }, (onError) {
      print("Error working with the api");
    });
  }
  Autogenerated futurekyc;
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
      futurekyc = Autogenerated.fromJson(jsonDecode(onSuccess['response']));
      //print("walletqrcode>>>>>>> " + futureAlbum.data.phone.toString());
      setState(() {});
    }, (onError) {
      print("Error working with the api");
      logout();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreenPage(),
          ),
        );
      },
      child: Scaffold(
          appBar: appBar('Deposit'),
      backgroundColor:Color(0xFF18222C),
        body: userid1 == null ?
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: MainScreenPage(),
              ),
            );
          },
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(image: new AssetImage("assets/bg.png"), fit: BoxFit.cover,),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Login ',
                    style: TextStyle(color: Colors.white, fontSize: 18,),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blue,
                      border: Border.all(color: Colors.blue)),
                ),

              ],
            ),
          ),
        ):
        FutureBuilder<Autogenerated>(
            builder: (context, snapshot){
              if (futureAlbum != null){
              double inr = double.parse(futureAlbum.data.iNRBalance.toStringAsFixed(3));
              String inrWallet = NumberFormat.decimalPattern().format(inr);
                return Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(image: new AssetImage("assets/bg.png"), fit: BoxFit.cover,),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'INR',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'berlinsans',
                                          letterSpacing: 0.8,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Image.asset("./assets/images/rupee1.png",scale: 13,),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "\u{20B9}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'berlinsans',
                                          letterSpacing: 1,
                                          fontSize:18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "$inrWallet",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'berlinsans',
                                          letterSpacing: 1,
                                          fontSize:20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset("./assets/images/inr_deposit.png",scale: 2.8,),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: MaterialButton(
                          height: 40,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async{
    var rsp = await response();
    var message = rsp['message'];
    var data = rsp['data'];
    var record = data['record'];
    var kycApproved = record['kycApproved'];
    if(kycApproved == false){
    Fluttertoast.showToast(
    msg:  "KYC not Approved",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18.0);
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                InstantDeposit()),
      );
    }





                          },
                          //color:Color(0xFF81C1DF),
                          color:Color(0xFF144A7D),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "PROCEED",
                            style: TextStyle(
                              //fontFamily: 'berlinsans',
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.only(top: 80),
                  child: CircularProgressIndicator(strokeWidth: 6.0,
                      backgroundColor: Colors.green,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));



            }
        )

      ),
    );
  }
}





/* */