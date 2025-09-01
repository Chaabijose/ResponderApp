import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../widgets/loaders/loader.dart';
import '../../models/args/args_images_viewer.dart';
import '../../theme/app_colors.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key});
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  /// Data *********************************************************************
  late final PageController _pageController;
  final ArgsImagesViewer args = Get.arguments;

  @override
  void initState() {
    _pageController = PageController(initialPage: args.initialIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: SizedBox(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(width: 38, height: 38, margin: const EdgeInsets.symmetric(horizontal: 24), decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kWhite
                  ),  child: Center(child: Icon(Icons.arrow_back_ios_new, size: 22.r,),),)),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView(
                    controller: _pageController,
                    children: args.images
                        .map((e) => PhotoView(
                        loadingBuilder: (_, __) => const Center(child: Loader(size: LoaderSize.normal)),
                        imageProvider: CachedNetworkImageProvider(e)))
                        .toList(),
                  ),
                  if(args.images.length>1)
                  SmoothPageIndicator(
                      controller: _pageController,
                      count: args.images.length,
                      effect: ExpandingDotsEffect(
                          activeDotColor: kPrimary,
                          dotColor: kPrimary.withOpacity(0.6),
                          dotWidth: 6,
                          dotHeight: 6,
                          expansionFactor: 4,
                          spacing: 4))
                ],
              ),
            ),
          ],
        ).paddingSymmetric(vertical: 20),
      ),
    );
  }
}
