import 'package:smart360/view/onboarding/onboarding_info.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: "Hoş Geldin!",
        descriptions:
            "Bu uygulama, evinizi ve arabanızı akıllı hale getirerek hayatınızı kolaylaştırmayı hedefliyor. Şimdi ilk adımı atarak, ESP ile modeme bağlanabilir ve akıllı sistemlerin dünyasına adımınızı atabilirsiniz.\n Hadi başlayalım!",
        image: "assets/images/login.png"),
    OnboardingInfo(
        title: "Modeme Bağlan",
        descriptions:
            "Şimdi, akıllı sistemlerinizi kontrol etmek için modemle bağlanmanız gerekiyor. Lütfen Wi-Fi ağınızı seçin ve şifrenizi girin. Ardından, devam etmek için \"Başla\" düğmesine dokunun.",
        image: "assets/images/login.png"),
  ];
}
