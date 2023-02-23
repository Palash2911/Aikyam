import 'package:flutter/material.dart';
import '../constants.dart';

class Post extends StatefulWidget {
  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
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
                CircleAvatar(),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'smile foundation',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.share),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 8),
                        Text('February 17, 2023'),
                        SizedBox(width: 16),
                        Icon(Icons.location_on),
                        SizedBox(width: 8),
                        Text('Pune'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              child: Column(
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sed leo id risus volutpat suscipit. Sed consequat magna in enim faucibus, vel volutpat risus sagittis. Donec interdum ipsum non mauris malesuada, sit amet iaculis felis auctor.',
                    maxLines: _isExpanded ? null : 100,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 5),
                      Text('No of required volunteers: '),
                      Text('20')
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_city),
                      SizedBox(width: 5),
                      Text('City: '),
                      Text('Pune')
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 5),
                      Text('Location: '),
                      Text('D Y patil college of Engineering'),
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
            // Image.asset(
            //   'assets/images/post.png',
            //   width: double.infinity,
            //   height: 250,
            //   fit: BoxFit.cover,
            // ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: toggleLike,
                  child: Card(
                    color: kprimaryColor,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          _isLike
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: ksecondaryColor,
                                ),
                          SizedBox(width: 8),
                          Text('123'),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: toggleApply,
                  child: Card(
                    color: kprimaryColor,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          _isApply
                              ? Icon(
                                  Icons.add_box_outlined,
                                  color: ksecondaryColor,
                                )
                              : Icon(
                                  Icons.add_box_rounded,
                                  color: ksecondaryColor,
                                ),
                          SizedBox(width: 8),
                          Text('Apply'),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8),
                    Text('202'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
