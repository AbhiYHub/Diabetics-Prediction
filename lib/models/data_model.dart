class DataModel {
  String? pregnant;
  String? glucose;
  String? bp;
  String? skin;
  String? insulin;
  String? bmi;
  String? age;
  String? result;
  String? prediction;
  String? timestamp;

  DataModel({
    this.pregnant,
    this.glucose,
    this.bp,
    this.skin,
    this.insulin,
    this.bmi,
    this.age,
    this.result,
    this.prediction,
    this.timestamp
  });

  factory DataModel.fromMap(map) {
    return DataModel(
        pregnant: map["pregnant"],
        glucose: map["glucose"],
        bp: map["bp"],
        skin: map["skin"],
        insulin: map["insulin"],
        bmi: map["bmi"],
        age: map["age"],
        result: map["result"],
        prediction: map["prediction"],
        timestamp: map["timestamp"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "pregnant": pregnant,
      "glucose": glucose,
      "bp": bp,
      "skin": skin,
      "insulin": insulin,
      "bmi": bmi,
      "age": age,
      "result": result,
      "prediction": prediction,
      "timestamp": timestamp,
    };
  }
}
