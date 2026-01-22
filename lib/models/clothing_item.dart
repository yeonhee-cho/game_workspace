import 'dart:ui';

class ClothingItem {
  final String id;
  final String name;
  final int type; // 0: 헤어 1: 상의 2: 하의 3: 신발 4: 악세사리
  final Color color;

  ClothingItem(
     this.id,
     this.name,
     this.type,
     this.color,
  );

  /*
  ClothingItem(
    {
      this.id,
      this.name,
      this.type,
      this.color,
    }
  );
  */
}