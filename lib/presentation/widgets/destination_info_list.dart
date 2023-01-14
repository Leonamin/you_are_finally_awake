import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_finally_awake/core/entity/create_destination_info.dart';
import 'package:you_are_finally_awake/core/entity/location.dart';
import 'package:you_are_finally_awake/presentation/widgets/destination_info_provider.dart';

class DestinationInfoList extends StatefulWidget {
  const DestinationInfoList({super.key});

  @override
  State<DestinationInfoList> createState() => _DestinationInfoListState();
}

class _DestinationInfoListState extends State<DestinationInfoList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = DestinationInfoProvider();
        provider.call();
        return provider;
      },
      child: Consumer<DestinationInfoProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                flex: 8,
                child: ListView.builder(
                  itemCount: provider.destinationInfoList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      provider
                          .deleteInfo(provider.destinationInfoList[index].id);
                    },
                    child: Container(
                      child: Text(provider.destinationInfoList[index].title),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        provider.addInfo(
                          CreateDestinationInfo(
                              title: "테스트",
                              location: Location(
                                latitude: 37,
                                longitude: 127,
                                altitude: 0,
                              ),
                              radius: 100,
                              periodicMinute: 1),
                        );
                      },
                      child: Text("추가"))),
            ],
          );
        },
      ),
    );
  }
}
