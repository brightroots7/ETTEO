checkNull(String value) {
  return value == null || value == "" ? "-" : value;
}

checkEmpty(String value) {
  return value == null || value == "" ? "" : value;
}

bool isEmptyString(String value) {
  return (value == null || value == "");
}
