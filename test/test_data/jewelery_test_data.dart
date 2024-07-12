import 'package:gemchase_clean_arch/features/jewelery/domain/entity/jewelery_entity.dart';

class JeweleryTestData {
  JeweleryTestData._();

  static List<JeweleryEntity> getJeweleryTestData() {
    List<JeweleryEntity> lstJewelerys = [
      const JeweleryEntity(
        jeweleryId: "66866535a153e37e393a0c6d",
        jeweleryName: "silverring",
        jeweleryPrice: 1234567891012,
        jeweleryDescription: "jijijippppbbbaannpp",
        jeweleryCategory: "jewelery",
        jeweleryImage: "1720083765052-Silver ring.png",
        createdAt: "2024-07-04T09:02:45.054+00:00", 
        buyCount: 0,
      ),
      const JeweleryEntity(
        jeweleryId: "6686c88310d451e450493e27",
        jeweleryName: "necklace",
        jeweleryPrice: 12345678913,
        jeweleryDescription: "jijijippppaa",
        jeweleryCategory: "jewelerys",
        jeweleryImage: "1720109187641-nose pin.png",
        createdAt: "2024-07-04T16:06:27.651+00:00",
        buyCount: 0,
      ),
      const JeweleryEntity(
        jeweleryId: "6686c8bc10d451e450493e29",
        jeweleryName: "ring",
        jeweleryPrice: 123456789133,
        jeweleryDescription: "jijijippppaae",
        jeweleryCategory: "jewelerysss",
        jeweleryImage: "1720109244001-bangle.png",
        createdAt: "2024-07-04T16:07:24.003+00:00",
        buyCount: 0,
      ),
      const JeweleryEntity(
        jeweleryId: "6686656aa153e37e393a0c73",
        jeweleryName: "silverring",
        jeweleryPrice: 1234567891012,
        jeweleryDescription: "jijijippppbbbaannpp",
        jeweleryCategory: "jewelery",
        jeweleryImage: "1720083818146-gold necklace.png",
        createdAt: "2024-07-04T09:03:38.148+00:00",
        buyCount: 0,
      ),
    ];

    return lstJewelerys;
  }
}
