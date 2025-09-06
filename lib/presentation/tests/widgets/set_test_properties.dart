import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
import 'package:bac_project/presentation/tests/widgets/options_widget.dart';
import 'package:flutter/material.dart';

class SetTestProperties extends StatelessWidget {
  const SetTestProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseIconWidget(),
        actions: [
          Center(
            child: Padding(
              // TODO: add padding
              padding: EdgeInsets.zero,
              // padding: PaddingResources.padding_5_0,
              child: Text('12/01'),
            ),
          ), // Question Num
        ],
        //
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '03:56 ', // Timer
                style: TextStyle(fontSize: 16),
              ),
              //
              Icon(Icons.timer_sharp),
            ],
          ),
        ),
      ),
      body: Container(
        // TODO: add padding
        padding: EdgeInsets.zero,
        // padding: PaddingResources.padding_5_2,
        child: Column(
          children: [
            Container(
              // TODO: add padding
              padding: EdgeInsets.zero,
              // margin: PaddingResources.padding_0_4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    // TODO: add padding
                    padding: EdgeInsets.zero,
                    // margin: PaddingResources.padding_0_5,
                    // padding: PaddingResources.padding_5_5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 0,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    child: Text(
                      'نص السؤال الذي يمكن ان يكون اي نص عشوائي يعبر عن السؤال لان النص يمثل السؤال بالتالي يجب ان يعبر عن السؤال اشد التعبير واوضح التعبير لايصال ان النص هوه سؤال',
                      style: TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ),

                  ///
                  OptionsWidget(),
                ],
              ),
            ),

            //
            Spacer(),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 5,
              children: [
                MaterialButton(
                  color: Theme.of(context).colorScheme.onPrimary,
                  textColor: Theme.of(context).colorScheme.primary,
                  minWidth: MediaQuery.of(context).size.width / 2 - 15,
                  height: MediaQuery.of(context).size.height * 0.07,
                  onPressed: () {
                    //
                  },
                  child: Text('السابق'),
                ),
                //
                MaterialButton(
                  color: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  minWidth: MediaQuery.of(context).size.width / 2 - 15,
                  height: MediaQuery.of(context).size.height * 0.07,
                  onPressed: () {
                    //
                  },
                  child: Text('التالي'),
                ),
              ],
            ),
            Padding(
              // TODO: add padding
              padding: EdgeInsets.zero,
              // padding: PaddingResources.padding_0_1,
            ),
          ],
        ),
      ),
    );
  }
}
