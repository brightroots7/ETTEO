import 'dart:convert';

getMap(dynamic obj) {
  if (obj == null) return Map<String, dynamic>();
  Map<String, dynamic> map;
  if (obj is String) {
    map = json.decode(obj);
  } else if (obj is Map<String, dynamic>) {
    map = obj;
  }
  return map;
}

// listFromJson<T>(T model, dynamic jsonString) {
//   List<T> list = List();
//     List templist = List();
//     // List<ContactModel>
//     if (jsonString is String) {
//       templist = json.decode(jsonString);
//     }
//     templist.forEach((f) => list.add(model.fromJson(getMap(f))));
//     return list;
// }

decode(dynamic o) => json.decode(o);

encode(dynamic o) => json.encode(o);
