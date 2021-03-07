import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_editor/jsonParser.dart';

// import 'view.dart';
import 'view2.dart';

const protoc = '''
{
  "bool": true,
  "string": "test",
  "number": 1.2,
   "namespaces":[
      "WalletClient"
   ],
   "name":[
      "Protocol"
   ],
   "version":{
      "major":0,
      "minor":0
   },
   "enumerations":{
      "Blockchains":[
         "BTC",
         "ETH",
         "MHC",
         "EOS",
         "TRX",
         "TBC"
      ]
   },
   "types":{
      "LogMessageRequest":{
         "enumerations":{
            "Level":[
               "Trace",
               "Info",
               "Warning",
               "Error",
               "Fatal"
            ]
         },
         "properties":{
            "level":{
               "type":"enum",
               "of":"Level"
            },
            "message":{
               "type":"string"
            }
         }
      },
      "TransferInfoResponse":{
         "types":{
            "Account":{
               "properties":{
                  "id":{
                     "type":"string"
                  },
                  "blockchain":{
                     "type":"enum",
                     "of":"Blockchains"
                  },
                  "token":{
                     "type":"string"
                  },
                  "amount":{
                     "type":"string"
                  },
                  "type":{
                     "type":"enum",
                     "of":"AccountType"
                  }
               }
            }
         },
         "properties":{
            "accounts":{
               "type":"array",
               "of":"Account"
            }
         }
      }
   },
   "requests":{
      "WidgetLog":{
         "payload":{
            "data":{
               "type":"LogMessageRequest"
            }
         },
         "response":{
            
         }
      },
      "TransferInfo":{
         "payload":{
            
         },
         "response":{
            "payload":{
               "data":{
                  "type":"TransferInfoResponse"
               }
            }
         }
      }
   },
   "events":{
      "Notification":{
         "payload":{
            "type":{
               "type":"enum",
               "of":"Notifications"
            }
         }
      }
   }
}
''';

void main() {
  parseJson(protoc);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        dividerColor: Colors.transparent,
      ),
      home: MyTest2(json: json.decode(protoc)),
    );
  }
}
