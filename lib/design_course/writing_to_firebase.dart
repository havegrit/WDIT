import 'package:cloud_firestore/cloud_firestore.dart';

//그룹 파이어베이스 연동 부분
void addGroup(String groupName, String groupCategory, String groupExplanation,
    int groupNumber) async {
  final String _groupName = groupName;
  final String _groupCategory = groupCategory;
  final String _groupExplanation = groupExplanation;
  final int _groupNumber = groupNumber;

  //카테고리 별로 컬렉션 저장.
  await FirebaseFirestore.instance
      .collection('groups')
      .doc('$_groupNumber')
      .set({
    'group_name': _groupName,
    'group_category': _groupCategory,
    'group_explanation': _groupExplanation,
    'group_number': _groupNumber
  });
}

//게시판 파이어베이스 연동 부분
void addNotice(
    String title, String content, int postNumber, int groupNumber) async {
  final String _title = title;
  final String _content = content;
  final int _postNumber = postNumber;
  final int _groupNumber = groupNumber;

  //카테고리 별로 컬렉션 저장.
  await FirebaseFirestore.instance
      .collection('groups')
      .doc('$_groupNumber')
      .collection('notice')
      .add({'title': _title, 'content': _content, 'number': _postNumber});
}

//약속 파이어베이스 연동 부분
void addAppointment(String apptName, String apptStartDate, String apptEndDate,
    String apptExplanation, int apptNumber, int groupNumber) async {
  final String _apptName = apptName;
  final String _apptStartDate = apptStartDate;
  final String _apptEndDate = apptEndDate;
  final String _apptExplanation = apptExplanation;
  final int _apptNumber = apptNumber;
  final int _groupNumber = groupNumber;

  //카테고리 별로 컬렉션 저장.
  await FirebaseFirestore.instance
      .collection('groups')
      .doc('$_groupNumber')
      .collection('appointment')
      .add({
    'name': _apptName,
    'start_date': _apptStartDate,
    'end_date': _apptEndDate,
    'explanation': _apptExplanation,
    'number': _apptNumber
  });
}
