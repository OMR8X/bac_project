import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/presentation/tests/widget/answers_widget.dart';
import 'package:flutter/material.dart';

class SetTestProperties extends StatelessWidget {
  const SetTestProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            //
            icon: Icon(Icons.close,size: 20),
            //
          ),
        actions: [
          Center(
            child: Padding(
              padding: PaddingResources.padding_5_0,
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
                '03:56 ',// Timer
                style: TextStyle(fontSize: 16),
              ),
              //
              Icon(Icons.timer_sharp),
            ],
          ),
        ),
      ),
      body: Container(
        padding: PaddingResources.padding_5_2,
        child: Column(
          children: [
            Container(
              margin: PaddingResources.padding_0_4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: PaddingResources.padding_0_5,
                    padding: PaddingResources.padding_5_5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 0,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    child: Text(
                      'نص السؤال الذي يمكن ان يكون اي نص عشوائي يعبر عن السؤال لان النص يمثل السؤال بالتالي يجب ان يعبر عن السؤال اشد التعبير واوضح التعبير لايصال ان النص هوه سؤال',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                  ///
                  AnswersWidget(),
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
            Padding(padding: PaddingResources.padding_0_1),
          ],
        ),
      ),
    );
  }
}
