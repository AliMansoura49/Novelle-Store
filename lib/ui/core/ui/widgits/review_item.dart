import 'dart:math';

import 'package:flutter/material.dart';
import 'package:store/ui/core/ui/widgits/stars_rating.dart';

import '../../../../domain/models/review/review.dart';
import 'package:intl/intl.dart';
class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({super.key,required this.review});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(
            _fakePersons[Random().nextInt(_fakePersons.length)],
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top row
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //name with email,
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          review.reviewerName,
                          style: textTheme.titleMedium,
                        ),
                        Text(
                          review.reviewerEmail,
                          style: textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant
                          ),
                        )
                      ]
                  ),
                  //date
                  Text(
                      DateFormat('MMM dd, yyyy').format(review.date),
                      style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant
                      )
                  )
                ],
              ),
              SizedBox(height: 4,),
              StarsRating(rating: review.rating,color: colorScheme.primary,),
              SizedBox(height: 4,),
              Flexible(
                child: Text(
                  review.comment,
                  style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

const List<String> _fakePersons = [
  "assets/images/p1.webp",
  "assets/images/p2.webp",
  "assets/images/p3.webp",
];
