import 'category model.dart';

List<Categorymodel> getCategories(){
  List<Categorymodel> category=new List<Categorymodel>();
  Categorymodel categorymodel= new Categorymodel();

  categorymodel.categorycardname="Entertainment";
  categorymodel.categorycardurl="image/category images/entertainment.png";
  category.add(categorymodel);

  categorymodel= new Categorymodel();
  categorymodel.categorycardname="Business";
  categorymodel.categorycardurl="image/category images/business.jpg";
  category.add(categorymodel);

  categorymodel= new Categorymodel();
  categorymodel.categorycardname="Science";
  categorymodel.categorycardurl="image/category images/science.jpg";
  category.add(categorymodel);

  categorymodel= new Categorymodel();
  categorymodel.categorycardname="Health";
  categorymodel.categorycardurl="image/category images/health.jpg";
  category.add(categorymodel);

  categorymodel= new Categorymodel();
  categorymodel.categorycardname="Technology";
  categorymodel.categorycardurl="image/category images/technology.jpg";
  category.add(categorymodel);

  categorymodel= new Categorymodel();
  categorymodel.categorycardname="sports";
  categorymodel.categorycardurl="image/category images/sports.jpg";
  category.add(categorymodel);

  return category;
}
