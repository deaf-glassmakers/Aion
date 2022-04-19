import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aions',
      home:Scaffold(
        appBar: AppBar(
          title: const Text('this is Aion'),
        ),
        body: const Center(
          child: Text('Hello time'),
        )
      ),
    );
  }
}

class SetTimer extends StatefulWidget {
  const SetTimer({Key? key}) : super(key: key);

  @override
  State<SetTimer> createState() => _SetTimerState();
}

class _SetTimerState extends State<SetTimer> {
  static const timer_duration = Duration(minutes: 10);
  Duration duration = Duration();
  Duration second_duration = Duration(seconds: 1);
  final stopwatch = Stopwatch();
  bool started = false;
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    start_timer();
    return Container();
  }

  @override
  void initState() {
    // call reset function every time object is added to vision tree
    super.initState();
    timer_reset();
  }

  void timer_reset() {
    // resets the timer to initial state or the current value based on a flag
    if (!started) {
      setState(() => duration = Duration());
    }
    else {
      setState(() => duration = timer_duration);

    }
  }

  void start_timer() {
    timer = Timer.periodic(second_duration, (timer) => { add_time() });
  }

  void add_time(){
    final addseconds = started? 1 : -1;
    setState(() {
      final seconds = duration.inSeconds + addseconds;
      if ( seconds < 0 ){
        timer?.cancel();
      }
      else{
        duration = Duration(seconds: seconds);
      }
    });

  }

  void stop_timer(){
    timer?.cancel();

  }

}

// Timer start_timer(time_seconds, stopwatch) {
//   var milliseconds = time_seconds * 1000;
//   stopwatch.start();
//   return Timer(Duration(milliseconds: milliseconds), () => {handleTimeout(stopwatch)});
// }

void handleTimeout(stopwatch){
  stopwatch.stop();
  //handle the timeout event with something
}