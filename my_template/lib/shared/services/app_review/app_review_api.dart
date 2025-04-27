import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_review_api.g.dart';

@riverpod
AppReviewApi appReviewApi(AppReviewApiRef ref) {
  return AppReviewApi();
}

class AppReviewApi {
  AppReviewApi();
  final InAppReview inAppReview = InAppReview.instance;

  Future<bool> askReview() async {
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
      return true;
    }
    return false;
  }
}
