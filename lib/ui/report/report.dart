// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rayka_secend_test/ui/report/bloc/report_bloc.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({Key? key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String startTime = '';

  String endTime = '';

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('گزارش سفر '),
        centerTitle: true,
      ),
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
                // color: Colors.grey,
                height: screenSize.height / 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              ).then((selectedDate) {
                                if (selectedDate != null) {
                                  // Do something with the selected date
                                  var year = selectedDate.year;
                                  var month = selectedDate.month;
                                  var day = selectedDate.day;
                                  setState(() {
                                    endTime = '$year$month$day';
                                  });
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue,
                              ),
                              width: screenSize.width / 2 - 15,
                              height: 50,
                              // color: Colors.red,
                              child: Center(
                                  child: Text(endTime.isEmpty
                                      ? 'تاریخ پایان'
                                      : endTime)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              ).then((selectedDate) {
                                if (selectedDate != null) {
                                  // Do something with the selected date
                                  var year = selectedDate.year;
                                  var month = selectedDate.month;
                                  var day = selectedDate.day;

                                  setState(() {
                                    startTime = '$year$month$day';
                                  });
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue,
                              ),
                              width: screenSize.width / 2 - 15,
                              height: 50,
                              // color: Colors.red,
                              child: Center(
                                  child: Text(startTime.isEmpty
                                      ? '  تاریخ شروع '
                                      : startTime)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    Colors.green),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {
                          context.read<ReportBloc>().add(SearchReport(
                                startTime: startTime.isEmpty ? '' : startTime,
                                endTime: endTime.isEmpty ? '' : endTime,
                              ));
                        },
                        child: const Text(
                          'جست و جو ',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<ReportBloc, ReportState>(
              builder: (context, state) {
                if (state is ReposrtScreenSuccess) {
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: state.report.result!.length,
                      itemBuilder: (context, index) {
                        var data = state.report.result![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${data.driver!.firstName!} ${data.driver!.lastName!}',
                                      ),
                                      const Text(' :نام راننده '),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(data.trip!.totalActualDistance!
                                          .ceil()
                                          .toString()),
                                      const Text(
                                        '  :مجموع فاصله طی شده ',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(data.trip!.totalDuration!
                                          .ceil()
                                          .toString()),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(' :زمان صرف شده'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                if (state is ReportScreenLoading) {
                  return const SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 300,
                    child: Center(
                      child: Text(
                          'لطفا مقادیر مناسب برای جست و جو انتخاب کنید '),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
