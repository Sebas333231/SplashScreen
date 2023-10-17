import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class Components{
  String image;
  String titulo;
  String descripcion;
  Widget backgroundColor;
  String imagen2;
  Color background;

  Components({
    required this.image,
    required this.titulo,
    required this.descripcion,
    required this.backgroundColor,
    required this.imagen2,
    required this.background
  });
}


List<Components> listaComponents = [
  Components(
      image: '../images/img1.svg',
      titulo: 'Explora el Mundo',
      descripcion: "Descubre destinos inexplorados, "
          "vive experiencias únicas y crea recuerdos que "
          "durarán toda la vida. ¡Únete a la comunidad viajera "
          "y haz realidad tus sueños de viaje!",
      backgroundColor: LottieBuilder.asset("../images/animation3.json", fit: BoxFit.cover,),
    imagen2: '../images/imga1.png',
    background: Colors.black
  ),
  Components(
      image: '../images/img2.svg',
      titulo: 'Viaja con Estilo',
      descripcion: 'Desde playas paradisíacas '
          'hasta metrópolis emocionantes, '
          'encuentra inspiración para tu '
          'próximo viaje y descubre '
          'ofertas exclusivas que harán que tu viaje sea inolvidable.',
      backgroundColor: Padding(
        padding: EdgeInsets.only(top: 180),
        child: LottieBuilder.asset(
          "../images/animation3.json",
          fit: BoxFit.cover,
        ),
      ),
      imagen2: '../images/imga2.png',
      background: Colors.white
  ),
  Components(
      image: '../images/img3.svg',
      titulo: 'Rutas Secretas',
      descripcion: '¿Buscas aventuras auténticas? Navega por '
          'nuestras rutas secretas y desentraña los tesoros '
          'ocultos que solo los viajeros más intrépidos conocen.',
      backgroundColor: LottieBuilder.asset("../images/animation3.json", fit: BoxFit.cover),
      imagen2: '../images/imga3.png',
      background: Colors.black
  ),
  Components(
      image: '../images/img4.svg',
      titulo: 'Planifica Tu Escape',
      descripcion: 'Ya sea una escapada de fin de semana o '
          'un viaje de ensueño, nuestra app te ayudará a planificar '
          'el escape perfecto. ¡Deja que la aventura comience!',
      backgroundColor: Padding(
        padding: EdgeInsets.only(top: 180),
        child: LottieBuilder.asset(
            "../images/animation3.json",
          fit: BoxFit.cover,
        ),
      ),
      imagen2: '../images/imga4.png',
      background: Colors.white
  ),
  Components(
      image: '../images/img5.svg',
      titulo: 'Viajar Transforma',
      descripcion: 'El viaje no solo cambia tus destinos, '
          'también cambia tu perspectiva. Únete a nuestra '
          'comunidad global de ''viajeros y descubre cómo viajar puede transformar tu vida.',
      backgroundColor: LottieBuilder.asset("../images/animation3.json", fit: BoxFit.cover),
      imagen2: '../images/imga5.png',
      background: Colors.black
  ),
];