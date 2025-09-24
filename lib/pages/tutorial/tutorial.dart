import 'package:flutter/material.dart';
import 'package:journapp/common/bottomNavigationBar.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  bool _isPlaying = true;
  double _progress = 16.55 / 56.05; // example progress
  int _currentIndex = 0; // highlight "Community"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Now Playing",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Media Preview
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      "assets/tutorial.png", // replace with your asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              /// Description text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                  "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                  "Ut enim ad minim veniam, consequat. Duis aute irure dolor in "
                  "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
                  "Exceptetur sint occaecat cupidatat non proident, sunt in culpa qui officia "
                  "deserunt mollit anim id est laborum.\n\n"
                  "Exceptetur sint occaecat cupidatat non proident, sunt in culpa qui officia "
                  "deserunt mollit anim id est laborum.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 20),

              /// Progress bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6,
                        ),
                      ),
                      child: Slider(
                        value: _progress,
                        onChanged: (value) {
                          setState(() {
                            _progress = value;
                          });
                        },
                        activeColor: Colors.teal,
                        inactiveColor: Colors.teal.shade100,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("16:55", style: TextStyle(color: Colors.black54)),
                        Text("56:05", style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Playback controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.repeat, size: 28, color: Colors.black87),
                  const Icon(
                    Icons.skip_previous,
                    size: 34,
                    color: Colors.black87,
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () {
                      setState(() {
                        _isPlaying = !_isPlaying;
                      });
                    },
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const Icon(Icons.skip_next, size: 34, color: Colors.black87),
                  const Icon(Icons.shuffle, size: 28, color: Colors.black87),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      /// Bottom Navigation (external widget)
      bottomNavigationBar: SafeArea(
        top: false,
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
