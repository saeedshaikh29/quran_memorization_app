import 'package:flutter/material.dart';

class ReaderPage extends StatelessWidget {
  final int initialPage;

  const ReaderPage({
    super.key,
    required this.initialPage,
  });

  @override
  Widget build(BuildContext context) {
    final controller = PageController(
      initialPage: initialPage - 1,
    );
    return Scaffold(
      appBar: AppBar(
      ),
      body: PageView.builder(
        controller: controller,
        reverse: true,
        itemCount: 604,
        itemBuilder: (context, index) {
          final pageNumber = (index + 1).toString().padLeft(3, '0');

          return Stack(
            children: [

              Positioned.fill(
                child: InteractiveViewer(
                  child: Image.asset(
                    'assets/mushaf_jpg/page-$pageNumber.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsGeometry.only(bottom: 17.0),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}