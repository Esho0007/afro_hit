import 'package:afro_hit/constants/colors.dart';
import 'package:afro_hit/constants/text_style.dart';
import 'package:afro_hit/pages/player_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/players_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: whiteColor,
            ),
          ),
        ],
        leading: const Icon(
          Icons.sort_rounded,
          color: whiteColor,
        ),
        title: Text(
          "Afro Hit",
          style: ourStyle(family: bold, size: 18),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No Song Found"),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Obx(
                      () => ListTile(
                        title: Text(
                          snapshot.data![index].displayNameWOExt,
                          style: ourStyle(family: bold, size: 20),
                        ),
                        subtitle: Text(
                          "${snapshot.data![index].artist}",
                          style: ourStyle(family: regular, size: 10),
                        ),
                        leading: QueryArtworkWidget(
                          id: snapshot.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(
                            Icons.music_note,
                            color: whiteColor,
                            size: 32,
                          ),
                        ),
                        trailing: controller.playIndex.value == index &&
                                controller.isPlaying.value
                            ? const Icon(
                                Icons.play_arrow,
                                color: whiteColor,
                                size: 26,
                              )
                            : null,
                        onTap: () {
                          Get.to(() => Player(data: snapshot.data!),
                              transition: Transition.downToUp);
                          controller.playSong(snapshot.data![index].uri, index);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
