import 'package:aikyam/views/Screens/Ngo/NApplicantsScreen.dart';
import 'package:aikyam/views/Screens/User/NgoProfileScreen.dart';
import 'package:aikyam/views/constants.dart';
import 'package:aikyam/views/widgets/PopUpMenu.dart';
import 'package:aikyam/views/widgets/fillbutton.dart';
import 'package:flutter/material.dart';

class ActivityPost extends StatefulWidget {
  const ActivityPost({super.key});

  @override
  State<ActivityPost> createState() => _ActivityPostState();
}

class _ActivityPostState extends State<ActivityPost> {
  final List<String> _imgPost = [
    'assets/images/post.png',
    'assets/images/post2.png',
    'assets/images/post3.png',
  ];

  bool _isExpanded = true;
  bool _isLike = true;
  bool _isApply = true;

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void toggleLike() {
    setState(() {
      _isLike = !_isLike;
    });
  }

  void toggleApply() {
    setState(() {
      _isApply = !_isApply;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(initialPage: 0);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kpostColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NgoProfile(),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      color: const Color(0xffFF0E58),
                      child: Image.asset('assets/images/dp.jpg'),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'smile foundation',
                          style: kTextPopM16,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 4),
                        Text(
                          'Feb 17,2023',
                          style: kTextPopR14,
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.location_on),
                        Text(
                          'Pune',
                          style: kTextPopR14,
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                dotmenu(),
                // GestureDetector(
                //   onTap: () {},
                //   child: Icon(
                //     Icons.share,
                //     size: 32.0,
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              child: Column(
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sed leo id risus volutpat suscipit. Sed consequat magna in enim faucibus, vel volutpat risus sagittis. Donec interdum ipsum non mauris malesuada, sit amet iaculis felis auctor.',
                    style: kTextPopR14,
                    maxLines: _isExpanded ? null : 100,
                    overflow: TextOverflow.ellipsis,
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
                      Text('Location: ', style: kTextPopB14),
                      Expanded(
                        child: Text(
                          'D Y patil college of Engineering',
                          style: kTextPopR14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: toggleExpand,
              child: Text(
                _isExpanded ? 'See more' : 'see less',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _imgPost.length,
                  itemBuilder: ((context, index) {
                    return Image.asset(_imgPost[index]);
                  })),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  text: 'Delete Post',
                  onPressed: () {},
                ),
                SizedBox(
                  width: 25.0,
                ),
                AppButton(
                  text: 'View Applicants',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApplicantsScreen(),),);
                  },
                ),

                // GestureDetector(
                //   onTap: toggleLike,
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       side: BorderSide(color: kprimaryColor),
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     color: kpostColor,
                //     child: Container(
                //       padding: EdgeInsets.all(8.0),
                //       child: Text(
                //         'Delete Post',
                //         style: kTextPopR14.copyWith(color: kprimaryColor),
                //       ),
                //     ),
                //   ),
                // ),
                // Expanded(
                //   child: GestureDetector(
                //     onTap: toggleLike,
                //     child: Card(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       color: kprimaryColor,
                //       child: Container(
                //         padding: EdgeInsets.all(8.0),
                //         child: Center(
                //           child: Text(
                //             'Delete Post',
                //             style: kTextPopR14.copyWith(color: ksecondaryColor),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                // Expanded(
                //   child: GestureDetector(
                //     onTap: toggleLike,
                //     child: Card(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       color: kprimaryColor,
                //       child: Container(
                //         padding: EdgeInsets.all(8.0),
                //         child: Center(
                //           child: Text(
                //             'View Applicants',
                //             style: kTextPopR14.copyWith(color: ksecondaryColor),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
