import 'package:flutter/material.dart';
import 'workflow_shared_widgets.dart';

class HousingListingItem {
  final String title;
  final String location;
  final String badge;
  final String ratingScore;
  final String reviewsCount;
  final List<String> features;
  final String price;
  final String oldPrice;
  final String imageAsset;

  const HousingListingItem({
    required this.title,
    required this.location,
    required this.badge,
    required this.ratingScore,
    required this.reviewsCount,
    required this.features,
    required this.price,
    required this.oldPrice,
    required this.imageAsset,
  });
}

const List<HousingListingItem> defaultHousingListings = [
  HousingListingItem(
    title: 'Kendall Square Academic Suites',
    location: '0.4 miles from MIT Campus · Cambridge, MA',
    badge: 'Bills Included (Wi-Fi & Heat)',
    ratingScore: '4.9',
    reviewsCount: '42 reviews',
    features: ['Private Ensuite', 'Indian Student Roommates', 'Metro 2 Min'],
    price: '\$1,150 / mo',
    oldPrice: '~\$2,500 / mo',
    imageAsset: 'assets/images/abroad/unistay_kendall_square.png',
  ),
  HousingListingItem(
    title: 'Harvard Yard Student Commons',
    location: '0.6 miles from Harvard · Cambridge, MA',
    badge: 'Verified Dorm Partner',
    ratingScore: '4.8',
    reviewsCount: '28 reviews',
    features: ['Shared 2-Bed Flat', 'Fully Furnished Kitchen', 'Study Lounge'],
    price: '\$980 / mo',
    oldPrice: '~\$3,000 / mo',
    imageAsset: 'assets/images/abroad/unistay_harvard_yard.png',
  ),
  HousingListingItem(
    title: 'Beacon Hill Collegiate Loft',
    location: '1.2 miles from Boston University · Boston, MA',
    badge: 'High Security & Gym',
    ratingScore: '4.95',
    reviewsCount: '56 reviews',
    features: ['Studio Apartment', 'In-Unit Washer/Dryer', '24/7 Concierge'],
    price: '\$1,350 / mo',
    oldPrice: '~\$3,200 / mo',
    imageAsset: 'assets/images/abroad/unistay_beacon_hill.png',
  ),
];

/// Dedicated UniStay Student Housing Screen View.
class UniStayHousingView extends StatefulWidget {
  final VoidCallback? onCompleted;

  const UniStayHousingView({super.key, this.onCompleted});

  @override
  State<UniStayHousingView> createState() => _UniStayHousingViewState();
}

class _UniStayHousingViewState extends State<UniStayHousingView> {
  String _selectedCity = 'Boston (MIT / Harvard)';

  void _showTourModal(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        String selectedDate = 'Tomorrow, 3:00 PM';
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCBD5E1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.view_in_ar_rounded, color: Color(0xFF1D61E7), size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Virtual 3D Room Tour', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF0F172A))),
                            Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11.5, color: Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.close_rounded, color: Color(0xFF64748B))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Select Tour Window:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: Color(0xFF0F172A))),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Tomorrow, 3:00 PM', 'Tomorrow, 5:30 PM', 'Saturday, 11:00 AM'].map((t) {
                      final isSelected = selectedDate == t;
                      return InkWell(
                        onTap: () => setModalState(() => selectedDate = t),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7.5),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF1D61E7) : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(t, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, color: isSelected ? Colors.white : const Color(0xFF334155))),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Virtual Tour booked for $selectedDate!'),
                            backgroundColor: const Color(0xFF059669),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D61E7),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: const Text('Confirm Virtual Tour Booking →', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Location Selector Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: PopupMenuButton<String>(
            onSelected: (val) => setState(() => _selectedCity = val),
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.location_on_rounded, size: 18, color: Color(0xFF334155)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(_selectedCity, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded, size: 22, color: Color(0xFF334155)),
              ],
            ),
            itemBuilder: (context) => [
              'Boston (MIT / Harvard)',
              'London (Imperial / UCL)',
              'Munich (TUM / LMU)',
              'Toronto (U of T / York)',
            ].map((city) {
              return PopupMenuItem<String>(
                value: city,
                child: Text(
                  city,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: _selectedCity == city ? FontWeight.w700 : FontWeight.w500,
                    color: _selectedCity == city ? const Color(0xFF1D61E7) : const Color(0xFF0F172A),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 14),

        // Housing Listing Cards
        ...defaultHousingListings.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              gradient: const LinearGradient(
                colors: [Colors.white, Color(0xFFFBFDFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1D61E7).withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                const CardVerticalAccents(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFECFDF5),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(item.badge, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF059669))),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 15),
                              const SizedBox(width: 2),
                              Text(item.ratingScore, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                              Expanded(
                                child: Text(' (${item.reviewsCount})', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Color(0xFF0F172A), letterSpacing: -0.2, height: 1.2)),
                          const SizedBox(height: 3),
                          Text(item.location, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF64748B))),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: item.features.map((f) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                              decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(5)),
                              child: Text(f, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                            )).toList(),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.price, style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w900, color: Color(0xFF1D61E7), letterSpacing: -0.3)),
                                  Text(item.oldPrice, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w500, color: Color(0xFF94A3B8), decoration: TextDecoration.lineThrough)),
                                ],
                              ),
                              const Spacer(),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => _showTourModal(context, item.title),
                                  borderRadius: BorderRadius.circular(9),
                                  child: Ink(
                                    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7.5),
                                    decoration: BoxDecoration(color: const Color(0xFF1D61E7), borderRadius: BorderRadius.circular(9)),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Book 3D Tour', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                                        SizedBox(width: 3),
                                        Icon(Icons.chevron_right_rounded, size: 14, color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: 128,
                        height: 156,
                        child: Image.asset(
                          item.imageAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            'assets/images/abroad/abroad_unistay.png',
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              color: const Color(0xFFEFF6FF),
                              child: const Center(
                                child: Icon(Icons.apartment_rounded, color: Color(0xFF1D61E7), size: 36),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
