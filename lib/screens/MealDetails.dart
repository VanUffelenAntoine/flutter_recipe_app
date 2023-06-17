import 'package:flutter/material.dart';
import 'package:meal_app/models/MealDetailed.dart';
import 'package:meal_app/utils/api.dart';
import 'package:meal_app/widgets/CustomCachedNetworkImage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widgets/CustomProgressIndicator.dart';

class MealDetails extends StatefulWidget {
  const MealDetails({super.key, required this.id});

  final int id;

  @override
  State<StatefulWidget> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  late Future<MealDetailed> meals;

  late YoutubePlayerController _controller;
  
  youtubeUrlCheck(data){
    print(data.ytbLink);
    if (data.ytbLink != ''){
      return YoutubePlayer(
        controller: _controller = YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(
                data!.ytbLink) as String,
            flags: const YoutubePlayerFlags(
              mute: false,
              autoPlay: false,
              showLiveFullscreenButton: true,
            )),
        showVideoProgressIndicator: true,
        progressIndicatorColor: Theme.of(context).primaryColor,
        progressColors: ProgressBarColors(
            playedColor: Theme.of(context).primaryColor,
            handleColor: Theme.of(context).hoverColor
        ),
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
          ),
          const PlaybackSpeedButton(),
        ],
      );
    }

    return const Text('Youtube tutorial not available');
  }

  @override
  void initState() {
    super.initState();
    meals = fetchSingleMealById(widget.id);
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MealDetailed>(
      future: meals,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                title: Text(snapshot.data!.meal),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 125),
                              child: Column(
                                children: [
                                  Text('Category: ${snapshot.data!.category}'),
                                  const SizedBox(height: 10),
                                  Text('Origin: ${snapshot.data!.area}'),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            _ingredientsList(snapshot.data!.ingredientsWMeasure)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxWidth: 250, maxHeight: 250),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: CustomCachedNetworkImage(
                                      url: snapshot.data!.thumb),
                                ))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text('Instructions: ',
                    style: Theme.of(context).textTheme.titleLarge,),

                    Row(
                      children: [
                        Flexible(child: Text(snapshot.data!.instructions)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text('Youtube tutorial: ',
                      style: Theme.of(context).textTheme.titleLarge,),
                    youtubeUrlCheck(snapshot.data)
                  ],
                ),
              ));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return CustomProgressIndicator();
      },
    );
  }
}

Widget _ingredientsList(ingreds) {
  return SizedBox(
    height: 200,
    width: 125,
    child: ListView.builder(
        itemCount: ingreds.length,
        itemBuilder: (context, index) {
          var listNr = index + 1;
          var ingredsList = ingreds.entries.toList();
          return ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(
              '$listNr.  ${ingredsList[index].key}',
              style: const TextStyle(fontSize: 12),
            ),
            subtitle: Text('${ingredsList[index].value}',
                style: const TextStyle(fontSize: 10)),
          );
        }),
  );
}
