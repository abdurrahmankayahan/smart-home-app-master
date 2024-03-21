import 'package:smart360/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart360/src/models/data_models/propertyModel.dart';

class DarkContainer extends StatelessWidget {
  ///TODO: Dark Container yerine  bir  container uygulaması yaz  parametresi  propertyModel olsun.
  ///
  ///Pin bilgisine göre  sadece veri okur  (sensör) veya  1-0  çıktı verir. (role)
  ///(Pin bilgisine göre  containerda button   veya sadece text alanı tutulmalı)
  ///özellik ismi olmalı
  ///özelliği ifade eden resim için resim url bilgisi tutmalı
  /// value  bilgisi için  verileri almalı
  /// button olan container için on click fonk.  olmalı
  ///  uzerine tıklandığında  özellikleri ayarlamak değişiklik yapmak için  sayfaları  açan fonk. olmalı (void callback  & Function)
  /// bu bilgileri içeren properyModel  yazılmalı
  ///
  /// !! Veritabanı bu bilgilere göre tekrar oluşturulmalıdır.

  final PropertyModel propertyModel;
  final VoidCallback onTap;
  final VoidCallback switchButton;
  final VoidCallback switchFav;
  final bool isFav;


  const DarkContainer({
    Key? key,
    required this.propertyModel,
    required this.onTap,
    required this.switchButton,
    required this.isFav,
    required this.switchFav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: getProportionateScreenWidth(140),
        height: getProportionateScreenHeight(140),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              // propertyModel.getPinIO == "0"
              //     ? Colors.green[100]
              //     :
              propertyModel.getItsOn != null && propertyModel.getPinVal == "1"
                  ? const Color.fromRGBO(0, 0, 0, 1)
                  : const Color(0xffededed),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(6),
          ),
          child: Column(
            crossAxisAlignment: propertyModel.getItsOn != null
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: propertyModel.getItsOn != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: propertyModel.getItsOn != null &&
                              propertyModel.getItsOn == true
                          ? const Color.fromRGBO(45, 45, 45, 1)
                          : const Color(0xffdadada),
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(45, 45)),
                    ),
                    child: SvgPicture.asset(
                      propertyModel.propertyIcon==""?"assets/icons/svg/info.svg":propertyModel.propertyIcon!,
                      color: propertyModel.getItsOn != null &&
                              propertyModel.getPinVal == "1"
                          ? Colors.amber
                          : const Color(0xFF808080),
                    ),
                  ),
                  propertyModel.getItsOn != null
                      ? InkWell(
                          onTap: switchFav,
                          child: Icon(
                            Icons.star_rounded,
                            color:
                                isFav ? Colors.amber : const Color(0xFF808080),
                            // color: Color(0xFF808080),
                          ),
                        )
                      : Row()
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    propertyModel.getPropertyName.toString(),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: propertyModel.getItsOn != null &&
                                  propertyModel.getPinVal == "1"
                              ? Colors.white
                              : Colors.black,
                        ),
                  ),
                ],
              ),
              propertyModel.getPinIO == "1"
                  ? propertyModel.getItsOn != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              propertyModel.getItsOn == null
                                  ? 'Özellik'
                                  : (propertyModel.getItsOn != null &&
                                          propertyModel.getPinVal == "1"
                                      ? 'Açık'
                                      : 'Kapalı'),
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: propertyModel.getItsOn != null &&
                                            propertyModel.getPinVal == "1"
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                            ),
                            InkWell(
                              onTap: switchButton,
                              child: Container(
                                width: 48,
                                height: 25.6,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: propertyModel.getItsOn != null &&
                                          propertyModel.getPinVal == "1"
                                      ? Colors.black
                                      : const Color(0xffd6d6d6),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    width: propertyModel.getItsOn != null &&
                                            propertyModel.getPinVal == "1"
                                        ? 2
                                        : 0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    propertyModel.getItsOn != null &&
                                            propertyModel.getPinVal == "1"
                                        ? const Spacer()
                                        : const SizedBox(),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : Row()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          propertyModel.getPinVal.toString(),
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: propertyModel.getItsOn != null &&
                                        propertyModel.getPinVal == "1"
                                    ? Colors.white
                                    : Colors.black,
                              ),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
