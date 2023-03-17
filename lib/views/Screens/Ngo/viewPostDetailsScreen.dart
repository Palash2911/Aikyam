import 'package:aikyam/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ViewDetails extends StatefulWidget {
  const ViewDetails({super.key});

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
          child: Column(
            children: [
              Text(
                'This is the title of the drive river cleaning organize by d y patil pune ',
                style: kTextPopB24,
              ),
              SizedBox(width: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 4),
                      Text(
                        'Feb 17,2023',
                        style: kTextPopM16,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        'Pune',
                        style: kTextPopM16,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                  'This is the description of the drive river cleaning organized by d y patil pune here more and more text is written this text has no limit this can be anything here written anything hi hello how are you This is the description of the drive river cleaning oraganized by d y patil pune here more and more text is written this text has no limit this can be anything here written anything hi hello how are you ',
                  style: kTextPopR16),
              SizedBox(
                width: 12.0,
              ),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 5),
                  Text('No of required volunteers: ', style: kTextPopB14),
                  Text('20', style: kTextPopR14)
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.location_city),
                  SizedBox(width: 5),
                  Text('City: ', style: kTextPopB14),
                  Text('Pune', style: kTextPopR14)
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 5),
                  Text('Drive Location: ', style: kTextPopB14),
                  Expanded(
                    child: Text(
                      'D Y patil college of Engineering',
                      style: kTextPopR14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.category),
                  SizedBox(width: 5),
                  Text('Drive category: ', style: kTextPopB14),
                  Expanded(
                    child: Text(
                      'Education',
                      style: kTextPopR14,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // toggleApply();
                  });
                },
                child: Text('Apply'
                    // _isApply ? widget.applyStatus : 'Applied',
                    ),
              ),
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    child: Image.asset('assets/images/dp.jpg'),
                  ),
                ),
                title: Text('Smile Foundation'),
                subtitle: Text('more info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
