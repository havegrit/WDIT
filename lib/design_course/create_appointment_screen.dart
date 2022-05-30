import 'package:best_flutter_ui_templates/design_course/create_post_screen.dart';
import 'package:best_flutter_ui_templates/design_course/writing_to_firebase.dart';
import 'package:flutter/material.dart';

var apptNumber = 1;

class appointment extends StatefulWidget {
  const appointment({Key? key}) : super(key: key);

  @override
  State<appointment> createState() => _appointmentState();
}

class _appointmentState extends State<appointment>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  late String apptName;
  String _startDate = '시작 날짜';
  String _endDate = '종료 날짜';
  late String apptExplanation;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("약속 만들기"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Row(
                    children: [
                      AnimatedOpacity(
                        opacity: opacity1,
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('약속 이름'),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 45,
                                    child: TextField(
                                      controller: controller1,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  const Text('약속 날짜'),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  OutlinedButton(
                                    style: ButtonStyle(
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: Colors.black)),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(140, 45))),
                                    onPressed: () {
                                      Future<DateTime?> selectedDate =
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2022),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 365)));

                                      selectedDate.then((value) {
                                        setState(() {
                                          _startDate =
                                              value.toString().substring(0, 10);
                                        });
                                      });
                                    },
                                    child: Text(
                                      _startDate,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Text(
                                      '~',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  OutlinedButton(
                                    style: ButtonStyle(
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: Colors.black)),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(140, 45))),
                                    onPressed: () {
                                      Future<DateTime?> selectedDate =
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2022),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 365)));

                                      selectedDate.then((value) {
                                        setState(() {
                                          _endDate =
                                              value.toString().substring(0, 10);
                                        });
                                      });
                                    },
                                    child: Text(
                                      _endDate,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  const Text('약속 설명'),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    width: 300,
                                    height: 300,
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 100,
                                      controller: controller2,
                                      style: TextStyle(),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedOpacity(
                    opacity: opacity2,
                    duration: const Duration(milliseconds: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              apptName = controller1.text;
                              apptExplanation = controller2.text;
                              addAppointment(apptName, _startDate, _endDate,
                                  apptExplanation, apptNumber, groupNumber);
                              apptNumber++;
                              Navigator.pop(context);
                            },
                            child: const Text(
                              '생성하기',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
