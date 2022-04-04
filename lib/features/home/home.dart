import 'package:attendance/features/checkin/check_attendance.dart';
import 'package:attendance/features/location/location.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  attendanceCard(String title, Function() onTap){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16),),
            const SizedBox(height: 16,),
            Text('$title time', style: TextStyle(color: Colors.white.withOpacity(.75)),),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome', style: Theme.of(context).textTheme.headline6,),
            const SizedBox(height: 12,),
            Text('Jangan lupa absen hari ini', style: Theme.of(context).textTheme.bodyText1,),
            const SizedBox(height: 24,),
            GestureDetector(
              onTap: ()=>Navigator.pushNamed(context, LocationScreen.route),
              child: Container(
                width: size.width,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey)
                ),
                child: const Text('lokasi kehadiran')
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: attendanceCard('Check in', ()=>Navigator.pushNamed(context, CheckIn.route, arguments: 'Checkin')),
                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: attendanceCard('Check out', ()=>Navigator.pushNamed(context, CheckIn.route, arguments: 'Checkout')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}