class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(
      {required this.title, required this.image, required this.subTitle});
}


class SliderViewObject{
  SliderObject sliderObject;
  int numberOfPage;
  int currentIndex;

  SliderViewObject({required this.sliderObject,required this.numberOfPage,required this.currentIndex});
}