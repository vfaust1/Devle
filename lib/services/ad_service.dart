import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart'; // Pour kIsWeb

class AdService {
  // On définit les IDs en dur ou on détecte la plateforme proprement sans dart:io
  String get _rewardedAdUnitId {
    if (kIsWeb) return ''; // Pas de pub sur le web pour l'instant
    
    // Astuce : on utilise defaultTargetPlatform au lieu de Platform.isAndroid
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'ca-app-pub-3940256099942544/5224354917'; // Test Android
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'ca-app-pub-3940256099942544/1712485313'; // Test iOS
    }
    return '';
  }

  RewardedAd? _rewardedAd;

  void loadRewardedAd() {
    // SÉCURITÉ : Si on est sur le Web, on arrête tout de suite
    if (kIsWeb) return; 

    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          print('$ad loaded.');
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          _rewardedAd = null;
        },
      ),
    );
  }

  void showRewardedAd({required VoidCallback onRewardEarned}) {
    // SÉCURITÉ WEB : Si on est sur le web, on donne la récompense direct (simulation)
    if (kIsWeb) {
      print("Web Mode: Ad skipped, reward granted.");
      onRewardEarned();
      return;
    }

    if (_rewardedAd == null) {
      print('Warning: The ad was not ready yet.');
      // En cas d'échec de chargement, on donne quand même la récompense pour ne pas frustrer
      onRewardEarned(); 
      loadRewardedAd();
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        loadRewardedAd();
        onRewardEarned();
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        print("User earned reward: ${rewardItem.amount} ${rewardItem.type}");
        onRewardEarned();
      },
    );
    
    _rewardedAd = null;
  }
}