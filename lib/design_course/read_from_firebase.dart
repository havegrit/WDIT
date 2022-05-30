import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

var _groupName = List.empty(growable: true);
var _groupCategory = List.empty(growable: true);
var _groupExplantion = List.empty(growable: true);
var _groupNum = List.empty(growable: true);
int? postLen;
late List<bool> isChecked = List<bool>.filled(postLen!, false, growable: true);

Future<List<QueryDocumentSnapshot>> fetchGroupData() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('groups').get();
  List<QueryDocumentSnapshot> groupData = querySnapshot.docs;
  postLen = groupData.length;
  for (var i = 0; i < postLen!; i++) {
    _groupName.add(groupData[i].get("group_name"));
    _groupCategory.add(groupData[i].get("group_category"));
    _groupExplantion.add(groupData[i].get("group_explanation"));
    _groupNum.add(groupData[i].get("group_number"));
  }
  return groupData;
}

var _title = List.empty(growable: true);
var _content = List.empty(growable: true);
var _postNum = List.empty(growable: true);

Future<List<QueryDocumentSnapshot>> fetchNoticeData() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('groups')
      .doc()
      .collection('notice')
      .get();
  List<QueryDocumentSnapshot> postData = querySnapshot.docs;
  postLen = postData.length;
  for (var i = 0; i < postLen!; i++) {
    _title.add(postData[i].get("title"));
    _content.add(postData[i].get("content"));
    _postNum.add(postData[i].get('number'));
  }
  return postData;
}

var _name = List.empty(growable: true);
var _startDate = List.empty(growable: true);
var _endDate = List.empty(growable: true);
var _explanation = List.empty(growable: true);
var _apptNum = List.empty(growable: true);

Future<List<QueryDocumentSnapshot>> fetchAppointmentData() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('groups')
      .doc()
      .collection('appointment')
      .get();
  List<QueryDocumentSnapshot> postData = querySnapshot.docs;
  postLen = postData.length;
  for (var i = 0; i < postLen!; i++) {
    _name.add(postData[i].get("name"));
    _startDate.add(postData[i].get("start_date"));
    _endDate.add(postData[i].get('end_date'));
    _explanation.add(postData[i].get('explanation'));
    _apptNum.add(postData[i].get('number'));
  }
  return postData;
}

class DrawPost extends StatefulWidget {
  const DrawPost({Key? key}) : super(key: key);

  @override
  State<DrawPost> createState() => _DrawPostState();
}

class _DrawPostState extends State<DrawPost> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder<void>(
            future: fetchNoticeData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: postLen,
                  itemBuilder: (BuildContext context, index) {
                    return Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(_title[index] +
                              "(생성번호: " +
                              _postNum[index].toString() +
                              ")"),
                        ),
                      ],
                    );
                  },
                  padding: const EdgeInsets.all(8.0),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class DrawAppointment extends StatefulWidget {
  const DrawAppointment({Key? key}) : super(key: key);

  @override
  State<DrawAppointment> createState() => _DrawAppointmentState();
}

class _DrawAppointmentState extends State<DrawAppointment> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder<void>(
            future: fetchAppointmentData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: postLen,
                  itemBuilder: (BuildContext context, index) {
                    return Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(_name[index] +
                              "(생성번호: " +
                              _apptNum[index].toString() +
                              ")"),
                        ),
                      ],
                    );
                  },
                  padding: const EdgeInsets.all(8.0),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
