class PlantsModel {
  String plant_Name;
  String plant_Picture;
  String plant_Description;
  String plant_Tips;
  int avg_GrowTime;

  PlantsModel(
      {this.plant_Name,
      this.plant_Picture,
      this.plant_Description,
      this.plant_Tips,
      this.avg_GrowTime});
}

final allPlants = [
  PlantsModel(
    plant_Name: 'Domates',
    plant_Picture: 'assets/images/Domates.jpg',
    plant_Description:
        'Domates (Solanum lycopersicum), patlıcangiller (Solanaceae) Ailesinden anavatanı Güney ve Orta Amerika olan bir yıllık yenebilen bir otsu bitki türü. 1-3 metre boya sahip olan domates bitkisinin hafif odunsu bir gövdesi vardır. 10-25 cm uzunluğunda olan yapraklarının üzerinde 5-9 yaprakçık bulunur.',
    plant_Tips: 'No tips yet',
    avg_GrowTime: 10,
  ),
  PlantsModel(
    plant_Name: 'Maydanoz',
    plant_Picture: 'assets/images/Maydanoz.jpg',
    plant_Description:
        'Maydanoz (Petroselinum crispum) maydanozgiller familyasından anavatanı Akdeniz havzası olan otsu bir bitki ve bitkinin sebze olarak kullanılan yapraklarıdır. İki yıllık bir bitki olan maydanoz ilk yıl yaprak rozetini ikinci yıl gövdesini ve tohumlarını oluşturur.',
    plant_Tips: 'No tips yet',
    avg_GrowTime: 10,
  ),
  PlantsModel(
    plant_Name: 'Marul',
    plant_Picture: 'assets/images/Marul.jpg',
    plant_Description:
        'Marul (Lactuca sativa) papatyagiller familyasından anavatanı Avrupa, Asya ve Afrika\'yı kapsayan geniş bir bölge olan tek yıllık bir bitki ve bitkinin genellikle sebze olarak kullanılan yapraklarıdır. Genellikle salata yapımında kullanılan marul ayrıca sandviç ve dürümlerin vazgeçilmez sebzesidir.',
    plant_Tips: 'No tips yet',
    avg_GrowTime: 10,
  ),
  PlantsModel(
    plant_Name: 'Biber',
    plant_Picture: 'assets/images/Biber.jpg',
    plant_Description:
        'İkiçeneklilerin patlıcangiller familyasından, bir yıllık otsu bir bitki (Capsicum annuum). ... Meyveleri taze sebze olarak, kırmızı biberin kurutulmasıyla elde edilen toz da baharat olarak kullanılır. Bibere acı tadını veren "capsaicin" adındaki alkaloiddir. Taze biberde C vitamini oldukça boldur.',
    plant_Tips: 'No tips yet',
    avg_GrowTime: 10,
  ),
  PlantsModel(
    plant_Name: 'Semizotu',
    plant_Picture: 'assets/images/Semizotu.jpg',
    plant_Description:
        'Semizotu, en çok 30 cm. kadar boylanabilen bir ya da çokyıllık otsu bir bitkidir. Yuvarlağa yakın oval biçimli, yeşil renkli etli ve sulu yaprakları vardır. Bu yapraklar ile yine etli ve sulu olan yaprak sapları yenilir. Bitkinin küçük çiçekleri genellikle sarı, bazen eflatun, pembe ya da kırmızı renkli olur.',
    plant_Tips: 'No tips yet',
    avg_GrowTime: 10,
  ),
];
