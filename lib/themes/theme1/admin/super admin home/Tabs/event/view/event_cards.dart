import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/utils/style/app_fonts.dart';

class EventCard extends StatelessWidget {
  final Map<String, String> eventData;
  const EventCard({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    const String placeholderImageUrl = 'https://tse1.mm.bing.net/th/id/OIP.CY8V1q5jIto0DasNLa_QegHaFS?rs=1&pid=ImgDetMain&o=7&rm=3';

    return SizedBox(
      height: height * 0.18,
      child: Card(
        color: Colors.grey.shade100,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        margin: EdgeInsets.symmetric(vertical: height * 0.01),
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.network(
                  eventData['image'] ?? placeholderImageUrl,
                  width: width * 0.28,
                  height: height * 0.16,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      placeholderImageUrl,
                      width: width * 0.28,
                      height: height * 0.16,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eventData['name'] ?? 'N/A',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppFonts.interBold,
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height * 0.005),
                        Text(
                          eventData['description'] ?? 'No description available',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppFonts.interRegular,
                            fontSize: width * 0.03,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, size: width * 0.04, color: Colors.grey),
                            SizedBox(width: width * 0.015),
                            Expanded(
                              child: Text(
                                eventData['location'] ?? 'No location specified',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppFonts.interRegular,
                                  fontSize: width * 0.032,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.005),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: width * 0.038, color: Colors.grey),
                            SizedBox(width: width * 0.018),
                            Expanded(
                              child: Text(
                                eventData['date'] ?? 'No date specified',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppFonts.interRegular,
                                  fontSize: width * 0.032,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
