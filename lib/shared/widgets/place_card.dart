import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../features/places/data/model/place_model.dart';

class PlaceCard extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback onTap;
  final VoidCallback onfav;
  final bool isFavorite;
  final int type;

  const PlaceCard({
    super.key,
    required this.place,
    required this.onTap,
    required this.onfav,
    required this.isFavorite,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 0.8, color: Colors.teal),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(10),
                    ),
                    child: Image.asset(
                      place.imageUrls[0],
                      width: 120,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => Image.asset(
                            'assets/images/Place1_1.jpg',
                            width: 120,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        RatingBar(
                          ignoreGestures: true,
                          ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.amber),
                            half: Transform.flip(
                              flipX: true,
                              child: const Icon(
                                Icons.star_half,
                                color: Colors.amber,
                              ),
                            ),
                            empty: const Icon(Icons.star, color: Colors.grey),
                          ),
                          allowHalfRating: true,
                          initialRating: 3.5,
                          minRating: 1,
                          maxRating: 5,
                          itemCount: 5,
                          itemSize: 20,
                          onRatingUpdate: (value) {},
                        ),
                        const SizedBox(height: 6),
                        Text(
                          place.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 18,
                              color: Colors.teal,
                            ),
                            Expanded(
                              child: Text(
                                "${place.location}",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        /*
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.ideographic,
                          children: [
                            Expanded(
                              child: Text.rich(
                                textAlign: TextAlign.start,
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: place.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "${type == 2 ? "\n" : ""}(${place.location})",
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (type == 1) const SizedBox(height: 10),
                        if (type == 1)
                          SizedBox(
                            height: 25,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(left: 10),
                              scrollDirection: Axis.horizontal,
                              children:
                                  place.activities.map((element) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 3,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 1,
                                        horizontal: 10,
                                      ),
                                      //width: 80,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: AutoSizeText(
                                        element["cost"] == 0
                                            ? "${element["name"]} ~ Free"
                                            : "${element["name"]} ~ \$${element["cost"]}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.teal.shade700,
                                          fontSize: 12,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                    */
                      ],
                    ),
                  ),
                ],
              ),

              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade200,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child:
                      type == 1
                          ? IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  isFavorite ? Colors.redAccent : Colors.white,
                            ),
                            focusColor: Colors.green,
                            onPressed: onfav,
                            tooltip:
                                isFavorite
                                    ? 'إزالة من المفضلة'
                                    : 'إضافة إلى المفضلة',
                            iconSize: 20,
                          )
                          : IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: onfav,
                            tooltip: 'حذف من المفضلة',
                            iconSize: 20,
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
