import 'dart:mirrors';

class Database {
  final List<Type> entities;
  final int version;

  const Database(this.entities, this.version);
}

abstract class PinpointDatabase {}
