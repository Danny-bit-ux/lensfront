// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

class AdverbModel {
  var id;
  int? images;
  var uid;
  var timestamp;
  var category;
  var category_id;
  var name;
  var price;
  var address;
  var description;
  var phone;
  var messages;
  var state;
  var type;
  var brand;
  var model;
  var color;
  var engine;
  var hp;
  var nm;
  var killometrs;
  var drive_type;
  var transmission;
  var year;
  var engine_volume;
  var engine_cylinders;
  var gears;
  var tact_numbers;
  var fuel_supply;
  var build_type;
  var order_type;
  var flour;
  var rights;
  var repair;
  var square;
  var cpu;
  var gpu;
  var ram;
  var memory_hard;
  var sex;
  var age;
  var size;
  var screen_size;
  var userName;
  var userRating;
  var userReviews;
  var ccid;
  AdverbModel({
    this.size,
    this.price,
    this.id,
    this.phone,
    this.hp,
    this.messages,
    this.category,
    this.uid,
    this.year,
    this.sex,
    this.age,
    this.color,
    this.timestamp,
    this.description,
    this.address,
    this.model,
    this.brand,
    this.engine,
    this.state,
    this.build_type,
    this.category_id,
    this.cpu,
    this.drive_type,
    this.engine_cylinders,
    this.engine_volume,
    this.flour,
    this.fuel_supply,
    this.gears,
    this.gpu,
    this.killometrs,
    this.memory_hard,
    this.nm,
    this.order_type,
    this.ram,
    this.repair,
    this.rights,
    this.screen_size,
    this.square,
    this.tact_numbers,
    this.transmission,
    this.type,
     this.images,
    this.ccid,
    this.userName,
    this.userRating,
    this.userReviews,
    this.name,
  });
  @override
  String toString() {
    // TODO: implement toString
    return '$size, $price, $type, $transmission,$tact_numbers, $square, $screen_size, $rights, $repair, $ram, $order_type, $nm, $state, $sex, $phone, $messages, $description, $age $address, $fuel_supply, $drive_type, $timestamp';
  }
}
//id, uid,timestamp,category,category_id,price,address,description,phone,messages,state,type,brand,model,color,engine,hp,nm,killometrs,drive_type,transmission,year,engine_volume,engine_cylinders,gears,tact_nubmers,fuel_supply,build_type,order_type,flour,rights,repair,square,cpu,gpu,ram,memory_hard,sex,age,size,screen_size
