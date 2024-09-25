import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double _currentRating = 0; // For rating
  final TextEditingController _reviewController = TextEditingController();
  List<Map<String, dynamic>> _reviews = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
        backgroundColor: Color(0xFF746DAA), // Using the same background color as home page
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Leave a Review',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            
            // Rating section (Star rating system)
            Text('Rate your experience:'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _currentRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _currentRating = index + 1.0;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 16),

            // Review text input field
            Text('Write your review:'),
            SizedBox(height: 8),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your review here',
              ),
            ),
            SizedBox(height: 16),

            // Submit button
            ElevatedButton(
              onPressed: () {
                if (_reviewController.text.isNotEmpty && _currentRating > 0) {
                  setState(() {
                    _reviews.add({
                      'rating': _currentRating,
                      'review': _reviewController.text,
                    });
                    _reviewController.clear(); // Clear the text field after submission
                    _currentRating = 0; // Reset the rating
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Review submitted!'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please provide a rating and review.'),
                  ));
                }
              },
              child: Text('Submit Review'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF746DAA), // Button color
              ),
            ),
            SizedBox(height: 24),

            // List of reviews
            Expanded(
              child: _reviews.isEmpty
                  ? Center(
                      child: Text(
                        'No reviews yet. Be the first to leave one!',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _reviews.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.person, size: 40, color: Colors.grey),
                          title: Row(
                            children: [
                              Text(
                                _reviews[index]['rating'].toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.star, color: Colors.amber, size: 16),
                            ],
                          ),
                          subtitle: Text(_reviews[index]['review']),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
