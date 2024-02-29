import 'package:smart360/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  
  final String iconAsset;
  final VoidCallback onTap;
  final String device;
  final String deviceCount;
  final bool? itsOn;
  final VoidCallback switchButton;
  final bool isFav;
  final VoidCallback switchFav;
  const DarkContainer({
    Key? key,
    required this.iconAsset,
    required this.onTap,
    required this.device,
    required this.deviceCount,
    required this.itsOn,
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
          color: itsOn!=null&&itsOn==true
              ? const Color.fromRGBO(0, 0, 0, 1)
              : const Color(0xffededed),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(6),
          ),
          child: Column(
            crossAxisAlignment:   itsOn!=null? CrossAxisAlignment.start:CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: itsOn!=null? MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: itsOn!=null&&itsOn==true
                          ? const Color.fromRGBO(45, 45, 45, 1)
                          : const Color(0xffdadada),
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(45, 45)),
                    ),
                    child: SvgPicture.asset(
                      iconAsset,
                      color: itsOn!=null&&itsOn==true ? Colors.amber : const Color(0xFF808080),
                    ),
                  ),
                 
                 itsOn!=null?
                  GestureDetector(
                    onTap: switchFav,
                    child: Icon(
                      Icons.star_rounded,
                      color: isFav ? Colors.amber : const Color(0xFF808080),
                      // color: Color(0xFF808080),
                    ),
                  ):Row()

                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: itsOn!=null&&itsOn==true ? Colors.white : Colors.black,
                        ),
                  ),
                  Text(
                    deviceCount,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Color.fromRGBO(166, 166, 166, 1),
                        fontSize: 13,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1.6),
                  ),
                ],
              ),
             
             
             itsOn!=null? 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itsOn==null?'Özellik':(itsOn!=null&&itsOn==true ? 'Açık' : 'Kapalı'),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: itsOn!=null&&itsOn==true ? Colors.white : Colors.black,
                        ),
                  ),
                  GestureDetector(
                    onTap: switchButton,
                    child: Container(
                      width: 48,
                      height: 25.6,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: itsOn!=null&&itsOn==true ? Colors.black : const Color(0xffd6d6d6),
                        border: Border.all(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          width: itsOn!=null&&itsOn==true ? 2 : 0,
                        ),
                      ),
                      child: Row(
                        children: [
                          itsOn!=null&&itsOn==true ? const Spacer() : const SizedBox(),
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
              ):Row()
             


            ],
          ),
        ),
      ),
    );
  }
}
