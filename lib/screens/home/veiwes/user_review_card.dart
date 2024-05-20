import 'package:flutter/material.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({Key? key, required this.onSubmit}) : super(key: key);

  final Function(String name, double rating, String review) onSubmit;

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  TextEditingController _nameController = TextEditingController();
  double _rating = 0.0;
  TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text('Rating: '),
              SizedBox(width: 10),
              Slider(
                value: _rating,
                min: 0,
                max: 5,
                divisions: 5,
                onChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
              Text(_rating.toStringAsFixed(1)),
            ],
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _reviewController,
            decoration: InputDecoration(
              labelText: 'Review',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your review';
              }
              return null;
            },
            maxLines: 3,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Submit the review
              widget.onSubmit(
                  _nameController.text, _rating, _reviewController.text);
              _nameController.clear();
              _rating = 0.0;
              _reviewController.clear();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
