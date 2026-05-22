import 'package:flutter/material.dart';
import '../../../../core/constants/surah_data.dart';
import '../../../../models/surah_model.dart';
import '../../../../widgets/notes_slider.dart';
// import '../widgets/notes_slider.dart';

class ReaderPage extends StatefulWidget {
  final int initialPage;

  const ReaderPage({
    super.key,
    required this.initialPage,
  });

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  late final PageController controller;
  bool isNotesOpen = false;
  bool isTestMode = false;
  static const double notesPanelWidth = 300;
  late int currentPage = 1;

  String getCurrentSurahName() {

    SurahModel currentSurah = surahs.first;

    for (final surah in surahs) {

      if (currentPage >= surah.startPage) {
        currentSurah = surah;
      } else {
        break;
      }
    }

    return currentSurah.name;
  }
  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage;
    controller = PageController(
      initialPage: widget.initialPage - 1,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        centerTitle: true,

        title: Text(
          getCurrentSurahName(),

          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [PageView.builder(
          controller: controller,
          reverse: true,
          onPageChanged: (index) {
            setState(() {
              currentPage = 604 - index;
            });
          },
          itemCount: 604,
          itemBuilder: (context, index) {

            final pageNumber =
            (index + 1).toString().padLeft(3, '0');

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
                        borderRadius:
                        BorderRadius.circular(20),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 17,
                        ),

                        child: Text(
                          '${index + 1}',

                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //learn widget tree fool
              ],
            );
          },
        ),
          AnimatedPositioned(
            right: isNotesOpen ? 285 : 0,

            top:
            MediaQuery.of(context).size.height *
                0.35,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() {

                  isNotesOpen = !isNotesOpen;

                });

              },

              child: Material(
                elevation: 8,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),

                child: Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 18,
                  ),

                  decoration: const BoxDecoration(
                    color: Colors.green,

                    borderRadius:
                    BorderRadius.horizontal(
                      left: Radius.circular(16),
                    ),
                  ),

                  child: const Icon(
                    Icons.menu_book,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.easeOut,
            duration:
            const Duration(milliseconds: 250),

            right: isNotesOpen
                ? 0
                : -(notesPanelWidth + 20),

            top: 0,
            bottom: 0,

            child: NotesSlider(
              key: ValueKey(currentPage),
              pageNumber: currentPage,
              isTestMode: isTestMode,
            ),
          ),
      ]
      ),
    );
  }
}