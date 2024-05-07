// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rayka_secend_test/ui/report/bloc/report_bloc.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key});

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
      body: SingleChildScrollView(
        child: SizedBox(
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
                                    setState(() {
                                      startTime = DateFormat('yyyy-MM-dd')
                                          .format(selectedDate);
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
                                child: Center(
                                  child: Text(
                                    startTime.isEmpty
                                        ? '  تاریخ شروع '
                                        : DateFormat('yyyy,MM,dd')
                                            .format(DateTime.parse(startTime)),
                                  ),
                                ),
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
                                    setState(() {
                                      endTime = DateFormat('yyyy-MM-dd')
                                          .format(selectedDate);
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
                                child: Center(
                                  child: Text(
                                    endTime.isEmpty
                                        ? 'تاریخ پایان'
                                        : DateFormat('yyyy,MM,dd')
                                            .format(DateTime.parse(endTime)),
                                  ),
                                ),
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
                                      borderRadius:
                                          BorderRadius.circular(10)))),
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
                    var data = state.report.result;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: data!.isNotEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                                // color: Colors.green,
                              ),
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text('نام راننده : '),
                                        Text(
                                          '${data.first.driver!.firstName!} ${data.first.driver!.lastName!}',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text('تعداد سفر : '),
                                        Text(
                                          '${data.first.trip!.totalCount!} ',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'مجموع فاصله طی شده : ',
                                        ),
                                        Text(
                                          '${NumberFormat.decimalPattern().format(data.first.trip!.totalActualDistance! ~/ 1000)} کیلومتر',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text('زمان صرف شده : '),
                                        Text(
                                            '${NumberFormat.decimalPattern().format(data.first.trip!.totalActualDuration! ~/ 60)}ساعت '),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                          : const SizedBox(
                              height: 300,
                              child: Center(
                                  child: Text(
                                      ' گزارشی یافت نشد لطفا مقادیر جست و جو را تغییر دهید '))),
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
      ),
    );
  }
}
