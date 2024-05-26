import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_practice/services/auth.dart';
import '../services/Db_firestore.dart';

class ListOfPara extends StatelessWidget {
  final collectionName;

  ListOfPara(this.collectionName);

  Widget build(context) {
    
    return FutureBuilder(
      future: db.getUserName(),
      builder: (futureCtx, AsyncSnapshot<String?> futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
          
        return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(collectionName)
                .orderBy('ID')
                .snapshots(),
            initialData: null,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              else if(snapshot.data == null)
                return Container();
              else
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, int index) {
                    var item = snapshot.data!.docs[index];

                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: item['completed']?Colors.green[200]:item['taken']?Colors.yellow[200]:Colors.grey[200],
                            // border:
                            //     Border.all(width: 3.0, color: Colors.grey[900]),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              'Para ${item['ID']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: item['completed']
                                      ? TextDecoration.lineThrough
                                      : null,
                                  decorationColor: Colors.white,
                                  decorationThickness: 2),
                                  
                            ),
                            subtitle: Row(
                              children: [
                                Text('Taker Name: '),
                                Text(
                                  '${item['taker']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: (auth.getCurrentUserId() == item['uid'] ? Colors.grey[900] : Colors.blue),
                                    ),
                                ),
                              ],
                            ),
                            trailing: Container(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text('Take',style: TextStyle(color: Colors.grey[900]),),
                                        Checkbox(
                                          value: item['taken'],
                                          onChanged: (value) {
                                            if (!item['completed'] &&
                                                (item['uid'] == "" ||
                                                    auth.getCurrentUserId() ==
                                                        item["uid"])) {
                                              db.updateDocumentForTaken(
                                                  collectionName, index, value!);
                                              value!
                                                  ? db.updateDocumentForTaker(
                                                      collectionName,
                                                      index,
                                                      futureSnapshot.data!)
                                                  : db.updateDocumentForTaker(
                                                      collectionName,
                                                      index,
                                                      'None');
                                              value!
                                                  ? db.updateDocumentForTakerUid(
                                                      collectionName,
                                                      index,
                                                      auth.getCurrentUserId())
                                                  : db.updateDocumentForTakerUid(
                                                      collectionName,
                                                      index,
                                                      '');
                                            }
                                          },
                                          activeColor: Colors.yellow[700],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Complete',style: TextStyle(color: Colors.grey[900]),),
                                        Checkbox(
                                          value: item['completed'],
                                          onChanged: (value) {
                                            if (item['taken'] &&
                                                auth.getCurrentUserId() ==
                                                    item['uid']) {
                                              db.updateDocumentForCompl(
                                                  collectionName, index, value!);
                                            }
                                          },
                                          activeColor: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 3.0,
                        ),
                      ],
                    );
                  },
                );
            });
      },
    );
  }
}
