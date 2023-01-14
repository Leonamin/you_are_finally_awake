import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:you_are_finally_awake/presentation/widgets/destination_info_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DestinationInfoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
