import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:navithera_client/feature/calendar/presentation/pages/pages/basics_example.dart';
import 'package:navithera_client/feature/calendar/presentation/pages/pages/complex_example.dart';
import 'package:navithera_client/feature/calendar/presentation/pages/pages/events_example.dart';
import 'package:navithera_client/feature/calendar/presentation/pages/pages/multi_example.dart';
import 'package:navithera_client/feature/calendar/presentation/pages/pages/range_example.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TableCalendar Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text('Basics'),
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TableBasicsExample(),
                    ),
                  ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: const Text('Range Selection'),
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TableRangeExample(),
                    ),
                  ),
            ),
            const SizedBox(height: 12.0),
            // ElevatedButton(
            //   child: const Text('Events'),
            //   onPressed:
            //       () => Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (_) => const TableEventsExample(),
            //         ),
            //       ),
            // ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: const Text('Multiple Selection'),
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TableMultiExample(),
                    ),
                  ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: const Text('Complex'),
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TableComplexExample(),
                    ),
                  ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
