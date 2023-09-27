import 'package:dio/dio.dart';
import 'package:entertainpoint/modules/downloadScreen/provider/download_screen_provider.dart';
import 'package:entertainpoint/utils/constant/constant.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter/statistics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../common/functions/download_function.dart';

class DownloadScreenView extends StatefulWidget {
  const DownloadScreenView({super.key});

  @override
  State<DownloadScreenView> createState() => _DownloadScreenViewState();
}

class _DownloadScreenViewState extends State<DownloadScreenView> {
  CancelToken? cancelToken;
  String downloadUrl = '';
  String downloadUrlAudio = '';
  String extenstion = '';
  List<Statistics> statistics = [];

  downloadFiles(url) async {
    final downloadScreenProvider = Provider.of<DownloadScreenProvider>(context, listen: false);
    if (url.contains('https://youtu.be') || url.contains('https://youtube.com')) {
      final ytExplode = YoutubeExplode();
      final video = await ytExplode.videos.get(url);

      final manifestVideo = await ytExplode.videos.streamsClient.getManifest(url);
      final streamInfoVideo = manifestVideo.video.bestQuality;
      final streamInfoAudio = manifestVideo.audio.first;

      downloadUrl = streamInfoVideo.url.toString();
      downloadUrlAudio = streamInfoAudio.url.toString();
      extenstion = 'mp4';

      final dio = Dio();
      final dir = await getApplicationDocumentsDirectory();
      final file = '${dir.path}/movie.$extenstion';
      final Audiofile = '${dir.path}/sound.mp3';
      final Totalfile = '${dir.path}/output.$extenstion';

      try {
        downloadScreenProvider.setIsDownload(true);
        cancelToken = CancelToken();

        downloadScreenProvider.setVideoFile();
        await dio.download(
          downloadUrl,
          file,
          onReceiveProgress: (received, total) {
            if (cancelToken?.isCancelled == true) {
              downloadScreenProvider.setIsDownload(true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text('Download Cancel'),
                    ),
                  ),
                ),
              );
              return;
            }

            downloadScreenProvider.setDownloadProgress(received / total);
          },
          cancelToken: cancelToken,
        );

        downloadScreenProvider.setVideoFile();
        await dio.download(
          downloadUrlAudio,
          Audiofile,
          onReceiveProgress: (received, total) {
            if (cancelToken?.isCancelled == true) {
              downloadScreenProvider.setIsDownload(true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text('Download Cancel'),
                    ),
                  ),
                ),
              );
              return;
            }

            downloadScreenProvider.setDownloadProgress(received / total);
          },
          cancelToken: cancelToken,
        );
        downloadScreenProvider.setIsDownload(false);

        downloadScreenProvider.setConverting();
        String command = "-i $file -i $Audiofile -c:v copy -c:a copy $Totalfile";
        FFmpegSession session = await FFmpegKit.executeAsync(command);
        FFmpegSession session2 = await FFmpegKit.executeAsync(command);
        statistics = await session2.getStatistics();
        downloadScreenProvider.setConverting();

        await saveFileToDirectory(Totalfile, '/Entertain Point', extenstion).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              content: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('File Saved To - ${value}'),
                ),
              ),
            ),
          );
        });
      } catch (e) {
        print(e.toString());
      }
    } else {
      downloadUrl = url;
      extenstion = 'mkv';
      final dio = Dio();
      final dir = await getApplicationDocumentsDirectory();
      final file = '${dir.path}/movie.$extenstion';

      try {
        downloadScreenProvider.setIsDownload(true);
        cancelToken = CancelToken();

        await dio.download(
          downloadUrl,
          file,
          onReceiveProgress: (received, total) {
            if (cancelToken?.isCancelled == true) {
              downloadScreenProvider.setIsDownload(true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text('Download Cancel'),
                    ),
                  ),
                ),
              );
              return;
            }

            downloadScreenProvider.setDownloadProgress(received / total);
          },
          cancelToken: cancelToken,
        );

        await saveFileToDirectory(file, '/Entertain Point', extenstion).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              content: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('File Saved To - ${value}'),
                ),
              ),
            ),
          );
        });
      } catch (e) {
        return;
      }
    }

    downloadScreenProvider.setProgressNull();
    setState(() {});
  }

  void cancelDownload() {
    if (cancelToken != null && !cancelToken!.isCancelled) {
      cancelToken!.cancel("Download cancelled by user");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final downloadScreenProvider = Provider.of<DownloadScreenProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!downloadScreenProvider.isDownloading)
              GestureDetector(
                onTap: () async {
                  final ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
                  final downloadFile = clipboardData!.text ?? '';
                  await downloadFiles(downloadFile);
                  setState(() {});
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Lottie.asset(downloadAnimation),
                      const Text('Copy Link & Press Here To Download'),
                    ],
                  ),
                ),
              ),
            if (downloadScreenProvider.isDownloading)
              Padding(
                padding: EdgeInsets.all(20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width,
                      child: CircularProgressIndicator(
                        value: downloadScreenProvider.downloadProgress,
                        color: Colors.pink,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.19,
                      child: Column(
                        children: [
                          if (!downloadScreenProvider.converting)
                            Text(
                              '${((downloadScreenProvider.downloadProgress) * 100).toInt()}%',
                              style: TextStyle(fontSize: 20),
                            ),
                          if (!downloadScreenProvider.converting)
                            Text(
                              downloadScreenProvider.videoFile ? 'Video' : 'Audio',
                            ),
                          if (!downloadScreenProvider.converting)
                            ElevatedButton(
                              onPressed: () {
                                cancelDownload();
                                downloadScreenProvider.setIsDownload(false);
                                setState(() {});
                              },
                              child: Text('Cancel'),
                            ),
                          if (downloadScreenProvider.converting)
                            Text(
                              'Execution ID - ${statistics.length}',
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allMovieList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          child: Image.network(
                            allMovieList[index]['image'],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      title: Text(allMovieList[index]['name']),
                      trailing: GestureDetector(
                        onTap: () {
                          downloadFiles(allMovieList[index]['link']);
                          setState(() {});
                        },
                        child: const CircleAvatar(
                          child: Icon(CupertinoIcons.cloud_download),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1)
          ],
        ),
      ),
    );
  }
}
