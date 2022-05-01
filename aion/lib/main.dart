import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wakelock/wakelock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  runApp(SetTimer());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
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
  final timerValueController = TextEditingController(text: timer_minutes.toString());
  Duration duration = Duration(minutes: timer_minutes);
  Duration second_duration = Duration(seconds: 1);
  final stopwatch = Stopwatch();
  bool started = false;
  bool setup = true;
  bool stopped = true;
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
                "enter minutes for timer here",
                textAlign: TextAlign.center,
              ) : const Text(
                  "change number of minutes here",
                  textAlign: TextAlign.center,
              ),
              Center(
              child: TextFormField(
              textAlign: TextAlign.center,
              // initialValue: timer_minutes.toString(),
              keyboardType: TextInputType.number,
              controller: timerValueController,
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
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(header,style: const TextStyle(color: Colors.black45)),
        )
      ],
    );
  }

  Widget buildButtons(){
    return
      setup ?
      Center(
        child:OutlinedButton(
          child: Text(
              "Start"
          ),
          onPressed: (){
            start_timer();
          },
        )
      )
          :
          started ?
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [OutlinedButton(
          child: Text(
              "Pause"
          ),
          onPressed: (){
            stop_timer();
          },
        ),
        ]
      )
    :
    Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            child: Text(
              "reset"
            ),
            onPressed: (){
              timer_reset();
            },
          ),
          OutlinedButton(
            child: Text(
                "continue"
            ),
            onPressed: (){
              start_timer();
            },
          ),
        ]
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
        // print(timerValueController.text.toString());
        duration = Duration(minutes: int.parse(timerValueController.text.toString()));
      });
    }
    else {
      setState(() => duration = Duration(minutes: int.parse(timerValueController.text.toString())));
    }
    setState(() {
      setup = true;
    });
  }

  void start_timer() {
    timer = Timer.periodic(second_duration, (timer) => { add_time() });
    setState(() {
      setup = false;
      started = true;
      stopped = true;
    });
  }

  void add_time(){
    final addseconds = started? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addseconds;
      if ( seconds < 0 ){
        timer?.cancel();
        setState(() {
          stopped = false;
          started = true;
        });
      }
      else{
        duration = Duration(seconds: seconds);
      }
    });

  }

  void stop_timer(){
    timer?.cancel();
    setState(() {
      stopped = true;
      started = false;
    });
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
