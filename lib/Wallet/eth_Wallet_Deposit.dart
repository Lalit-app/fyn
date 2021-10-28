import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fyn_zon/tokenPass.dart';
import 'package:share/share.dart';
import '../Model/qrCodeModel.dart';
import '../custom_appbar.dart';
import '../mainApi.dart';

class EthWalletDeposit extends StatefulWidget {
  String currncy;
  EthWalletDeposit({
    Key key,
    @required this.currncy,
  }) : super(key: key);
  @override
  _EthWalletDepositState createState() => _EthWalletDepositState();
}

class _EthWalletDepositState extends State<EthWalletDeposit> {

  Autogenerated futureAlbum;
  var file;
  Uint8List _bytes;

  @override
  void initState() {
    super.initState();
    fetchAlbum();

  }
  fetchAlbum() async {
    /* var data = {
    };*/
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var apiData = {
      "url":
      AuthToken.api+"/"+"getQRcodeETH"+"/"+prefs.getString('token')+"/"+prefs.getString('userid'),
      //"data": data
    };
    ApiClass.getApiCall(apiData, (onSuccess) {
      print(onSuccess.toString());
      futureAlbum = Autogenerated.fromJson(jsonDecode(onSuccess['response']));
      _bytes = base64.decode(futureAlbum.data.qrcode.split(',').last);
      setState(() {

      });

    }, (onError) {
      print("Error working with the api");
    }
    );
  }
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: appBar('ETH Deposit'),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(image: new AssetImage("assets/bg.png"), fit: BoxFit.cover,),
        ),
        child: FutureBuilder<Autogenerated>(
          //future: futureAlbum,
          builder: (context, snapshot){
            if (futureAlbum !=null){
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: new BoxDecoration(
                  image: new DecorationImage(image: new AssetImage("assets/bg.png"), fit: BoxFit.cover,),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   /* MaterialButton(
                      height: 40,
                      minWidth: 140,
                      onPressed: () {
                      },
                      //color:Color(0xFF81C1DF),
                      color:Color(0xFF144A7D),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Deposit",
                        style: TextStyle(
                          //fontFamily: 'berlinsans',
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),*/
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Ethereum',
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
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "\$${widget.currncy}",
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
                                SizedBox(
                                  height: 30,
                                ),
                                Image.asset("./assets/images/ethereumicon.png",scale: 7,),
                                SizedBox(
                                  height: 30,
                                ),
                                Image.memory(_bytes,scale: 1.2,),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(futureAlbum.data.address,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'berlinsans',
                                    letterSpacing: 1,
                                    fontSize:16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),),
                                SizedBox(
                                  height: 20,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    MaterialButton(
                                      height: 25,
                                      onPressed: () {
                                        Clipboard.setData(new ClipboardData(text: futureAlbum.data.address));
                                        key.currentState.showSnackBar(
                                            new SnackBar(content: new Text("Copied to Clipboard"),));
                                      },
                                      //color:Color(0xFF81C1DF),
                                      color:Color(0xFF144A7D),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30)),
                                      child: Text(
                                        "COPY",
                                        style: TextStyle(
                                          //fontFamily: 'berlinsans',
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                            color: Colors.white),
                                      ),
                                    ),

                                    MaterialButton(
                                      height: 25,
                                      onPressed: () {
                                        final RenderBox box = context.findRenderObject();
                                        Share.share(futureAlbum.data.address,
                                            subject: 'Address',
                                            sharePositionOrigin:
                                            box.localToGlobal(Offset.zero) &
                                            box.size);
                                      },
                                      //color:Color(0xFF81C1DF),
                                      color:Color(0xFF144A7D),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30)),
                                      child: Text(
                                        "SHARE",
                                        style: TextStyle(
                                          //fontFamily: 'berlinsans',
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                        ),
                      ],
                ),
              );
              //Text(snapshot.data.title);
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CircularProgressIndicator(
                    strokeWidth: 6.0,
                    backgroundColor: Colors.green,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)
                ));
          },
        ),
      ),
    );
  }
}
