import 'dart:async';
import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(SetTimer());
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
  static const int timer_minutes = 10;
  static const timer_duration = Duration(minutes: timer_minutes);
  Duration duration = Duration(minutes: timer_minutes);
  Duration second_duration = Duration(seconds: 1);
  final stopwatch = Stopwatch();
  bool started = false;
  bool setup = true;
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    // start_timer();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: const Center(
            child: Text("Timer"),
          )
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              setup? const Text(
                "enter number of minutes here",
                textAlign: TextAlign.center,
              ) : const Text(
                  "running",
                  textAlign: TextAlign.center,
              ),
              Center(
              child: TextFormField(
              textAlign: TextAlign.center,
              // initialValue: timer_minutes.toString(),
              initialValue: timer_minutes.toString(),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
                )
              ),
              Center(
                child: buildTime(),
              ),
              Center(
                child: buildButtons(),
              ),
            ]
          ),
        ),
      ),
    );
  }

  Widget buildTime(){
    final minutes = duration.inMinutes.toString();
    final seconds = duration.inSeconds.remainder(60).toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(content: minutes, header: "Minutes"),
        buildTimeCard(content: seconds, header: "Seconds"),
      ],
    );
  }

  Widget buildTimeCard({required String content, required String header}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Text(
            content,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,fontSize: 50
            ),
          )
        ),
        const SizedBox(height: 24,),
        Text(header,style: const TextStyle(color: Colors.black45)),
      ],
    );
  }

  Widget buildButtons(){
    return Column(

    );

  }

  @override
  void initState() {
    // call reset function every time object is added to vision tree
    super.initState();
    timer_reset();
  }

  void timer_reset() {
    // resets the timer to initial state or the current value based on a flag
    if (setup) {
      setState(() {
        duration = timer_duration;
      });
    }
    else if(!started){
      setState(() => duration = Duration());
    }
    else {
      setState(() => duration = timer_duration);
    }
    setState(() {
      setup = true;
    });
  }

  void start_timer() {
    timer = Timer.periodic(second_duration, (timer) => { add_time() });
    setState(() {
      setup = false;
    });
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