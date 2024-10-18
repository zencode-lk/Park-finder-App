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
        title: const Text('Reviews'),
        backgroundColor: const Color.fromARGB(255, 20, 20, 83),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Color(0xFF9E9EEC)],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Leave a Review',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            const Text('Rate your experience:'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _currentRating ? Icons.star : Icons.star_border,
                    color: const Color.fromARGB(255, 20, 20, 83),
                  ),
                  onPressed: () {
                    setState(() {
                      _currentRating = index + 1.0;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 16),

            const Text('Write your review:'),
            const SizedBox(height: 8),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your review here',
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                if (_reviewController.text.isNotEmpty && _currentRating > 0) {
                  setState(() {
                    _reviews.add({
                      'rating': _currentRating,
                      'review': _reviewController.text,
                    });
                    _reviewController.clear(); 
                    _currentRating = 0; 
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Review submitted!'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please provide a rating and review.'),
                  ));
                }
              },
              child: Text(
                'Submit Review',
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 20, 20, 83), // Button color
              ),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: _reviews.isEmpty
                ? const Center(
                    child: Text(
                      'No reviews yet. Be the first to leave one!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
            : ListView.builder(
                itemCount: _reviews.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.person, size: 40, color: Colors.grey),
                    title: Row(
                      children: [
                        Text(
                          _reviews[index]['rating'].toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
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
