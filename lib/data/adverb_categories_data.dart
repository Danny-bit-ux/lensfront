import 'package:flutter/cupertino.dart';
import '../model/adverb_category_model.dart';
import '../view/view_model/adv_car_viewmodel.dart';
import '../view/view_model/adv_home_viewmodel.dart';
import '../view/view_model/adv_moto_viewmodel.dart';

List<AdverbCategoryModel> adsCategories = [
  AdverbCategoryModel(id: 1, name: 'Транспорт', pods: [
    AdverbCategoryModel(
        id: 1001,
        name: 'Автомобили',
        pods: [],
        viewModel: CreateCarViewModel(),
        type: 'car'),
    AdverbCategoryModel(id: 1002, name: 'Мотоциклы и мототехника', pods: [
      AdverbCategoryModel(
          id: 10021,
          name: 'Мотоциклы',
          pods: [],
          viewModel: AdvMotoViewModel(),
          type: 'moto'),
      AdverbCategoryModel(id: 10022, name: 'Мопеды и скутеры', pods: [
        AdverbCategoryModel(
            id: 100221,
            name: 'Мопеды',
            pods: [],
            viewModel: AdvMotoViewModel(),
            type: 'moto'),
        AdverbCategoryModel(
            id: 100222,
            name: 'Скутеры',
            pods: [],
            viewModel: AdvMotoViewModel(),
            type: 'moto'),
      ]),
      AdverbCategoryModel(
          id: 10023,
          name: 'Вездеходы',
          pods: [],
          viewModel: AdvMotoViewModel(),
          type: 'moto'),
      AdverbCategoryModel(
          id: 10024,
          name: 'Снегоходы',
          pods: [],
          viewModel: AdvMotoViewModel(),
          type: 'moto'),
      AdverbCategoryModel(
          id: 10025,
          name: 'Картинг',
          pods: [],
          viewModel: AdvMotoViewModel(),
          type: 'moto'),
      AdverbCategoryModel(
          id: 10026,
          name: 'Квадроциклы и картинг',
          pods: [],
          viewModel: AdvMotoViewModel(),
          type: 'moto'),
    ]),
    AdverbCategoryModel(id: 1003, name: 'Грузовики и спецтехника', pods: [
      AdverbCategoryModel(
          id: 10031, name: 'Автобусы', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10032, name: 'Автодома', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10033, name: 'Автокраны', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10034, name: 'Бульдозеры', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10035, name: 'Грузовики', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10036,
          name: 'Коммунальная техника',
          pods: [],
          viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10037,
          name: 'Лёгкий коммерческий транспорт',
          pods: [],
          viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10038,
          name: 'Навесное оборудование',
          pods: [],
          viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10039, name: 'Погрузчики', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 100310, name: 'Прицепы', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 100311, name: 'Сельхозтехника', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 100312,
          name: 'Строительная техника',
          pods: [],
          viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 100313,
          name: 'Техника для лесозаготовки',
          pods: [],
          viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 100314, name: 'Тягачи', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 100315, name: 'Экскаваторы', pods: [], viewModel: SizedBox()),
    ]),
    AdverbCategoryModel(id: 1004, name: 'Водный транспорт', pods: [
      AdverbCategoryModel(
          id: 10041, name: 'Вёсельные лодки', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10042, name: 'Гидроциклы', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10043, name: 'Катера и яхты', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044,
          name: 'Моторные лодки и моторы',
          pods: [],
          viewModel: SizedBox()),
    ]),
    AdverbCategoryModel(id: 1004, name: 'Запчасти и аксессуары', pods: [
      AdverbCategoryModel(
          id: 10041, name: 'Запчасти', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10042,
          name: 'Шины, диски и колёса',
          pods: [],
          viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10043,
          name: 'Аудио- и видеотехника',
          pods: [],
          viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044, name: 'Аксессуары', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044, name: 'Тюнинг', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044,
          name: 'Багажники и фаркопы',
          pods: [],
          viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044, name: 'Инструменты', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044, name: 'Прицепы', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044, name: 'Экипировка', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044,
          name: 'Противоугонные устройства',
          pods: [],
          viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044,
          name: 'Масла и автохимия',
          pods: [],
          viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044, name: 'GPS-навигаторы', pods: [], viewModel: SizedBox()),
    ]),
  ]),
  AdverbCategoryModel(id: 2, name: 'Недвижимость', pods: [
    AdverbCategoryModel(id: 10044, name: 'Купить жильё', pods: [
      AdverbCategoryModel(id: 10044, name: 'Квартиры', pods: [
        AdverbCategoryModel(
            id: 10044,
            name: 'Вторичка',
            pods: [],
            viewModel: CreateAvdHomeViewModel(),
            type: 'home'),
        AdverbCategoryModel(
            id: 10044,
            name: 'Новостройки',
            pods: [],
            viewModel: CreateAvdHomeViewModel(),
            type: 'home'),
      ]),
      AdverbCategoryModel(
          id: 10044,
          name: 'Дома, дачи, коттеджи',
          pods: [],
          viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044, name: 'Комнаты', pods: [], viewModel: SizedBox()),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Снять посуточно', pods: [
      AdverbCategoryModel(id: 10044, name: 'Дома, дачи, коттеджи', pods: []),
      AdverbCategoryModel(
          id: 10044,
          name: 'Комнаты',
          pods: [],
          viewModel: CreateAvdHomeViewModel(),
          type: 'home'),
      AdverbCategoryModel(
          id: 10044,
          name: 'Квартиры',
          pods: [],
          viewModel: CreateAvdHomeViewModel(),
          type: 'home'),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Снять долгосрочно', pods: [
      AdverbCategoryModel(id: 10044, name: 'Дома, дачи, коттеджи', pods: []),
      AdverbCategoryModel(
          id: 10044,
          name: 'Комнаты',
          pods: [],
          viewModel: CreateAvdHomeViewModel(),
          type: 'home'),
      AdverbCategoryModel(
          id: 10044,
          name: 'Квартиры',
          pods: [],
          viewModel: CreateAvdHomeViewModel(),
          type: 'home'),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Коммерческая недвижимость', pods: [
      AdverbCategoryModel(
          id: 10044, name: 'Купить', pods: [], viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044, name: 'Снять', pods: [], viewModel: SizedBox()),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Другие категории', pods: [
      AdverbCategoryModel(
          id: 10044,
          name: 'Земельные участки',
          pods: [],
          viewModel: SizedBox()),
      AdverbCategoryModel(
          id: 10044,
          name: 'Гаражи и машиноместа',
          pods: [],
          viewModel: SizedBox()),
    ]),
  ]),
  AdverbCategoryModel(id: 3, name: 'Личные вещи', pods: [
    AdverbCategoryModel(id: 10044, name: 'Одежда, обувь, аксессуары ', pods: [
      AdverbCategoryModel(id: 10044, name: 'Женская одежда', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Женская обувь', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Мужская одежда', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Мужская обувь', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Сумки, рюкзаки и чемоданы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Аксессуары', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Детская одежда и обувь', pods: [
        AdverbCategoryModel(id: 10044, name: 'Для девочек', pods: []),
        AdverbCategoryModel(id: 10044, name: 'Для мальчиков', pods: []),
      ]),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Товары для детей и игрушки', pods: [
      AdverbCategoryModel(id: 10044, name: 'Детские коляски', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Детская мебель', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Велосипеды и самокаты', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Товары для кормления', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Автомобильные кресла', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Постельные принадлежности', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Игрушки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Товары для купания', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Товары для школы', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Красота и здоровье', pods: [
      AdverbCategoryModel(id: 10044, name: 'Приборы и аксессуары', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Парфюмерия', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Средства гигиены', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Косметика', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Средства для волос', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Медицинские изделия', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Другое', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Часы и украшения', pods: [
      AdverbCategoryModel(id: 10044, name: 'Ювелирные изделия', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Бижутерия', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Часы', pods: []),
    ]),
  ]),
  AdverbCategoryModel(id: 3, name: 'Электроника', pods: [
    AdverbCategoryModel(id: 3, name: 'Телефоны', pods: [
      AdverbCategoryModel(id: 3, name: 'Мобильные телефоны', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Аксессуары', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Рации', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Стационарные телефоны', pods: []),
    ]),
    AdverbCategoryModel(id: 3, name: 'Аудио и видео', pods: [
      AdverbCategoryModel(id: 3, name: 'Телевизоры и проекторы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Наушники', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Акустика, колонки, сабвуферы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Аксессуары', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Музыкальные центры, магнитолы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Усилители и ресиверы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Видеокамеры', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Видео, DVD и Blu-ray плееры', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Кабели и адаптеры', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Музыка и фильмы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Микрофоны', pods: []),
      AdverbCategoryModel(id: 10044, name: 'MP3-плееры', pods: []),
    ]),
    AdverbCategoryModel(id: 3, name: 'Товары для компьютера', pods: [
      AdverbCategoryModel(id: 10044, name: 'Комплектующие', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Мониторы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Сетевое оборудование', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Клавиатуры и мыши', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Аксессуары', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Джойстики и рули', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Флэшки и карты памяти', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Акустика', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Переносные жёсткие диски', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Веб-камеры', pods: []),
      AdverbCategoryModel(id: 10044, name: 'ТВ-тюнеры', pods: []),
    ]),
    AdverbCategoryModel(id: 3, name: 'Игры, приставки и программы', pods: [
      AdverbCategoryModel(id: 10044, name: 'Игровые приставки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Игры для приставок', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Программы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Компьютерные игры', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Ноутбуки', pods: []),
    AdverbCategoryModel(id: 10044, name: 'Настольные компьютеры', pods: [
      AdverbCategoryModel(id: 10044, name: 'Системные блоки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Моноблоки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Другое', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Фототехника', pods: [
      AdverbCategoryModel(
          id: 10044, name: 'Оборудование и аксессуары', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Объективы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Компактные фотоаппараты', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Плёночные фотоаппараты', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Зеркальные фотоаппараты', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Бинокли и телескопы', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Планшеты и электронные книги', pods: [
      AdverbCategoryModel(id: 10044, name: 'Планшеты', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Аксессуары', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Электронные книги', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Оргтехника и расходники', pods: [
      AdverbCategoryModel(id: 10044, name: 'МФУ, копиры и сканеры', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Принтеры', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Канцелярия', pods: []),
      AdverbCategoryModel(id: 10044, name: 'ИБП, сетевые фильтры', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Телефония', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Уничтожители бумаг', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Расходные материалы', pods: []),
    ]),
  ]),
  AdverbCategoryModel(id: 10044, name: 'Хобби и отдых', pods: [
    AdverbCategoryModel(id: 10044, name: 'Билеты и путешествия', pods: [
      AdverbCategoryModel(id: 10044, name: 'Карты, купоны', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Концерты', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Путешествия', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Спорт', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Театр, опера, балет', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Цирк, кино', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Шоу, мюзикл', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Велосипеды', pods: [
      AdverbCategoryModel(id: 10044, name: 'Горные', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Дорожные', pods: []),
      AdverbCategoryModel(id: 10044, name: 'ВМХ', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Детские', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Запчасти и аксессуары', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Книги и журналы', pods: [
      AdverbCategoryModel(
          id: 10044, name: 'Журналы, газеты, брошюры', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Книги', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Учебная литература', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Коллекционирование', pods: [
      AdverbCategoryModel(id: 10044, name: 'Банкноты', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Билеты', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Вещи знаменитостей, автографы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Военные вещи', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Грампластинки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Документы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Жетоны, медали, значки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Игры', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Календари', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Картины', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Киндер-сюрприз', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Конверты и почтовые карточки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Марки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Модели', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Монеты', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Открытки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Пепельницы, зажигалки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Пластиковые карточки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Спортивные карточки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Фотографии, письма', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Этикетки, бутылки, пробки', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Другое', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Музыкальные инструменты', pods: [
      AdverbCategoryModel(
          id: 10044, name: 'Аккордеоны, гармони, баяны', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Гитары и другие струнные', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Духовые', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Пианино и другие клавишные', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Скрипки и другие смычковые', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Ударные', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Для студии и концертов', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Аксессуары', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Охота и рыбалка', pods: []),
    AdverbCategoryModel(id: 10044, name: ' Спорт и отдых', pods: [
      AdverbCategoryModel(id: 10044, name: 'Бильярд и боулинг', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Дайвинг и водный спорт', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Единоборства', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Зимние виды спорта', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Игры с мячом', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Настольные игры', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Пейнтбол и страйкбол', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Ролики и скейтбординг', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Теннис, бадминтон, пинг-понг', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Туризм', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Фитнес и тренажёры', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Спортивное питание', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Другое', pods: []),
    ]),
  ]),
  AdverbCategoryModel(id: 10044, name: 'Для дома и дачи', pods: [
    AdverbCategoryModel(id: 10044, name: 'Ремонт и строительство', pods: [
      AdverbCategoryModel(id: 10044, name: 'Стройматериалы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Инструменты', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Сантехника, водоснабжение и сауна', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Двери', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Садовая техника', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Окна и балконы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Камины и обогреватели', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Готовые строения и срубы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Потолки', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Мебель и интерьер', pods: [
      AdverbCategoryModel(
          id: 10044, name: 'Кровати, диваны и кресла', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Шкафы, комоды и стеллажи', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Столы и стулья', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Текстиль и ковры', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Кухонные гарнитуры', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Предметы интерьера, искусство', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Освещение', pods: []),
      AdverbCategoryModel(
          id: 10044, name: ' Компьютерные столы и кресла', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Подставки и тумбы', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Другое', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Бытовая техника', pods: [
      AdverbCategoryModel(id: 10044, name: 'Для кухни', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Для дома', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Климатическое оборудование', pods: []),
      AdverbCategoryModel(
          id: 10044, name: 'Для индивидуального ухода', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Другое', pods: []),
    ]),
    AdverbCategoryModel(id: 10044, name: 'Продукты питания', pods: []),
    AdverbCategoryModel(id: 10044, name: 'Растения', pods: []),
    AdverbCategoryModel(id: 10044, name: 'Посуда и товары для кухни', pods: [
      AdverbCategoryModel(id: 10044, name: 'Посуда', pods: []),
      AdverbCategoryModel(id: 10044, name: 'Товары для кухни', pods: []),
    ]),
  ]),
];


