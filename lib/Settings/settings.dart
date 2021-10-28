import 'package:flutter/material.dart';
import 'package:fyn_zon/Asset/assets.dart';
import 'package:fyn_zon/animation/FadeAnimation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyn_zon/orderHistory.dart';
import 'package:fyn_zon/paymentOption.dart';
import 'package:fyn_zon/Settings/update_bank.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:page_transition/page_transition.dart';
import 'package:fyn_zon/tokenPass.dart';
import 'package:fyn_zon/signup.dart';
import 'package:fyn_zon/mainscreen.dart';
import 'package:fyn_zon/Settings/updateProfile.dart';
import 'Settings/bankAccount.dart';
import 'mainApi.dart';
import 'Settings/kyc.dart';
import 'login.dart';

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
  String panImage;
  String adhaarImage;
  String adhaarBackImage;
  bool updateMainNetBalance;
  bool kycApproved;
  String sId;
  int phone;
  String fname;
  String mname;
  String lname;
  String email;
  String pin;
  String accType;
  String bankAccNo;
  String ifscCode;
  String address;
  String adhaarNumber;
  String city;
  String dob;
  String panNumber;
  String pinCode;
  String state;
  String nationality;

  Data(
      {this.country,
        this.panImage,
        this.adhaarImage,
        this.adhaarBackImage,
        this.updateMainNetBalance,
        this.kycApproved,
        this.sId,
        this.phone,
        this.fname,
        this.mname,
        this.lname,
        this.email,
        this.pin,
        this.accType,
        this.bankAccNo,
        this.ifscCode,
        this.address,
        this.adhaarNumber,
        this.city,
        this.dob,
        this.panNumber,
        this.pinCode,
        this.state,
        this.nationality});

  Data.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    panImage = json['panImage'];
    adhaarImage = json['adhaarImage'];
    adhaarBackImage = json['adhaarBackImage'];
    updateMainNetBalance = json['updateMainNetBalance'];
    kycApproved = json['kycApproved'];
    sId = json['_id'];
    phone = json['phone'];
    fname = json['fname'];
    mname = json['mname'];
    lname = json['lname'];
    email = json['email'];
    pin = json['pin'];
    accType = json['accType'];
    bankAccNo = json['bankAccNo'];
    ifscCode = json['ifscCode'];
    address = json['address'];
    adhaarNumber = json['adhaarNumber'];
    city = json['city'];
    dob = json['dob'];
    panNumber = json['panNumber'];
    pinCode = json['pinCode'];
    state = json['state'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['panImage'] = this.panImage;
    data['adhaarImage'] = this.adhaarImage;
    data['adhaarBackImage'] = this.adhaarBackImage;
    data['updateMainNetBalance'] = this.updateMainNetBalance;
    data['kycApproved'] = this.kycApproved;
    data['_id'] = this.sId;
    data['phone'] = this.phone;
    data['fname'] = this.fname;
    data['mname'] = this.mname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['pin'] = this.pin;
    data['accType'] = this.accType;
    data['bankAccNo'] = this.bankAccNo;
    data['ifscCode'] = this.ifscCode;
    data['address'] = this.address;
    data['adhaarNumber'] = this.adhaarNumber;
    data['city'] = this.city;
    data['dob'] = this.dob;
    data['panNumber'] = this.panNumber;
    data['pinCode'] = this.pinCode;
    data['state'] = this.state;
    data['nationality'] = this.nationality;
    return data;
  }
}
class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> main() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs?.clear();
    prefs.remove('token');
    prefs.remove('userid');
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: MainScreenPage(),
      ),
    );
        (Route route) => false;
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
  Autogenerated futureAlbum;
  @override
  void initState() {
    super.initState();
    fetchAlbum1();
    setState(() {

    });
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
      print(prefs.getString('token'));
      setState(() {});
    }, (onError) {
      //Invalid token in the request 401
      print('lalit $onError');
      print("Error working with the api");
      logout();

    }

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF18222C),
        body: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(image: new AssetImage("assets/bg.png"), fit: BoxFit.cover,),
            ),
            child: userid == null ?
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Image.asset("./assets/images/settings.png",
                          height: 30,),
                        SizedBox(
                          width: 7,
                        ),
                        Text('Settings',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginScreen()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                      child: Row(
                          children: <Widget>[
                            Image.asset("./assets/image/user profile login.png",scale: 9,),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600),
                            ),
                          ]
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.lightBlueAccent,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SignupPage()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                      child: Row(
                          children: <Widget>[
                            Image.asset("./assets/image/user profile signup.png",scale: 9,),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'SignUp',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600),
                            ),
                          ]
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.lightBlueAccent,
                  )
                ],
              ),
            ):
            /*futureAlbum.message == "Invalid token in the request"
          ? main()
              :*/
            FutureBuilder<Autogenerated>(
                builder: (context, snapshot){
                  if (futureAlbum != null) {
                    String name = futureAlbum.data.fname;
                    String lastname = futureAlbum.data.lname;
                    String email = futureAlbum.data.email;
                    String city = futureAlbum.data.city;
                    String state = futureAlbum.data.state;
                    String nationality = futureAlbum.data.nationality;
                    String pin = futureAlbum.data.pin;
                    String pincode = futureAlbum.data.pinCode;
                    String phone = futureAlbum.data.phone.toString();
                    String accNumber = futureAlbum.data.bankAccNo.toString();
                    String ifsc = futureAlbum.data.ifscCode.toString();
                    return Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(image: new AssetImage("assets/bg.png"), fit: BoxFit.cover,),
                      ),
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                Image.asset("./assets/images/settings.png",
                                  height: 30,),
                                SizedBox(
                                  width: 7,
                                ),
                                Text('Settings',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold
                                  ),)
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  child: UpdateProfile(
                                    name,
                                    lastname,
                                    state,
                                    nationality,
                                    email,
                                    city,
                                    pincode,
                                    pin,
                                    phone,),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 25, 5, 0),
                              child: Row(
                                  children: <Widget>[
                                    Image.asset("./assets/image/user profile update profile.png",scale: 9,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Update Profile',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ]
                              ),
                            ),
                          ),

                          Divider(
                            color: Colors.lightBlueAccent,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (futureAlbum.data.kycApproved == true) {
                                return showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text("Kyc Approved !"),
                                        content: Text(
                                            "Your KYC has already approved."),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Ok", style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18
                                            ),),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                );
                              }
                              else {
                                print("lalit" +
                                    futureAlbum.data.kycApproved.toString());
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: KYC(
                                      name, lastname, state, city, pincode,),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                              child: Row(
                                  children: <Widget>[
                                    Image.asset("./assets/image/settings kyc.png",scale: 5,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'KYC',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.lightBlueAccent,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (futureAlbum.data.kycApproved == true) {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: UpdateBank(accNumber, ifsc),
                                  ),
                                );

                              } else {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: BankAccount(),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                              child: Row(
                                  children: <Widget>[
                                    Image.asset("./assets/image/settings bank payments.png",scale: 6,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Bank Account',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.lightBlueAccent,
                          ),

                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.blueGrey,
                                      title: Text("Confirm Logout"),
                                      content: Text(
                                          "Are you sure you want to logout?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("YES", style: TextStyle(
                                              color: Colors.white
                                          ),),
                                          onPressed: () {
                                            main();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text("NO", style: TextStyle(
                                              color: Colors.white
                                          ),),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  }
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                              child: Row(
                                  children: <Widget>[
                                    Image.asset("./assets/image/user profile logout.png",scale: 9,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Logout',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.lightBlueAccent,
                          )
                        ],
                      ),
                    );
                  }
                  else if (snapshot.hasError) {
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
        )
    );

  }
}