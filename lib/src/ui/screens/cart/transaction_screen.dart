import 'package:cart_app/src/assets/styles/app_colors.dart';
import 'package:cart_app/src/assets/styles/app_images.dart';
import 'package:cart_app/src/config/app_config.dart';
import 'package:cart_app/src/constants/app_text_constants.dart';
import 'package:cart_app/src/ui/navigate/screen_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transaction_Screen extends StatefulWidget {
  final Map arguments;
  Transaction_Screen({this.arguments, Key key}) : super(key: key);

  @override
  _Transaction_ScreenState createState() => _Transaction_ScreenState();
}

class _Transaction_ScreenState extends State<Transaction_Screen> {
  Map arguments;
  String response;

  @override
  void initState() {
    arguments = widget.arguments;
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _homeScreen(),
      child: SafeArea(
        child: Scaffold(
          body: _bodybuild(context),
        ),
      ),
    );
  }

  Container _bodybuild(BuildContext context) {
    String url;
    String response;
    if (arguments['error'] == null) {
      url = AppConfig.successImg;
      response = arguments['status'];
    } else {
      url = AppConfig.failureurl;
      response = arguments['error'];
    }
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppImages.productimage(imageurl: url, width: 150, height: 150),
            SizedBox(height: 30),
            Text("${response}",
                style: Theme.of(context).accentTextTheme.headline5),
            SizedBox(height: 100),
            Container(
              height: 50,
              width: 140,
              child: RaisedButton(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    40.0,
                  ),
                ),
                color: AppColors.appBackgroundColor,
                onPressed: () => _homeScreen(),
                // _placeOrder(cartFullList),
                child: Text(AppTextConstants.BACK,
                    style: Theme.of(context).accentTextTheme.headline6),
              ),
            ),
          ],
        ),
      ),
    );
  }

Future<void>  _homeScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(ScreenRoutes.HOMEPAGE, (route) => false);
  }
}

// class _HomePageState extends State<HomePage> {
//   Future<UpiResponse> _transaction;
//   UpiIndia _upiIndia = UpiIndia();
//   List<UpiApp> apps;

//   @override
//   void initState() {
//     _upiIndia.getAllUpiApps().then((value) {
//       setState(() {
//         apps = value;
//       });
//     });
//     super.initState();
//   }

//   Future<UpiResponse> initiateTransaction(String app) async {
//     return _upiIndia.startTransaction(
//       app: app,
//       receiverUpiId: 'packiyaraj44@okaxis',
//       receiverName: 'Md Azharuddin',
//       transactionRefId: 'TestingUpiIndiaPlugin',
//       transactionNote: 'Not actual. Just an example.',
//       amount: 1.00,
//     );
//   }

//   Widget displayUpiApps() {
//     if (apps == null)
//       return Center(child: CircularProgressIndicator());
//     else if (apps.length == 0)
//       return Center(child: Text("No apps found to handle transaction."));
//     else
//       return Center(
//         child: Wrap(
//           children: apps.map<Widget>((UpiApp app) {
//             return GestureDetector(
//               onTap: () {
//                 _transaction = initiateTransaction(app.app);
//                 setState(() {});
//               },
//               child: Container(
//                 height: 100,
//                 width: 100,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Image.memory(
//                       app.icon,
//                       height: 60,
//                       width: 60,
//                     ),
//                     Text(app.name),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('UPI'),
//       ),
//       body: Column(
//         children: <Widget>[
//           displayUpiApps(),
//           Expanded(
//             flex: 2,
//             child: FutureBuilder(
//               future: _transaction,
//               builder: (BuildContext context,
//                   AsyncSnapshot<UpiResponse> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasError) {
//                     return Center(child: Text('An Unknown error has occured'));
//                   }
//                   UpiResponse _upiResponse;
//                   _upiResponse = snapshot.data;
//                   if (_upiResponse.error != null) {
//                     String text = '';
//                     switch (snapshot.data.error) {
//                       case UpiError.APP_NOT_INSTALLED:
//                         text = "Requested app not installed on device";
//                         break;
//                       case UpiError.INVALID_PARAMETERS:
//                         text = "Requested app cannot handle the transaction";
//                         break;
//                       case UpiError.NULL_RESPONSE:
//                         text = "requested app didn't returned any response";
//                         break;
//                       case UpiError.USER_CANCELLED:
//                         text = "You cancelled the transaction";
//                         break;
//                     }
//                     return Center(
//                       child: Text(text),
//                     );
//                   }
//                   String txnId = _upiResponse.transactionId;
//                   String resCode = _upiResponse.responseCode;
//                   String txnRef = _upiResponse.transactionRefId;
//                   String status = _upiResponse.status;
//                   String approvalRef = _upiResponse.approvalRefNo;
//                   switch (status) {
//                     case UpiPaymentStatus.SUCCESS:
//                       print('Transaction Successful');
//                       break;
//                     case UpiPaymentStatus.SUBMITTED:
//                       print('Transaction Submitted');
//                       break;
//                     case UpiPaymentStatus.FAILURE:
//                       print('Transaction Failed');
//                       break;
//                     default:
//                       print('Received an Unknown transaction status');
//                   }
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text('Transaction Id: $txnId\n'),
//                       Text('Response Code: $resCode\n'),
//                       Text('Reference Id: $txnRef\n'),
//                       Text('Status: $status\n'),
//                       Text('Approval No: $approvalRef'),
//                     ],
//                   );

//                 } else
//                   return Text(' ');
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
