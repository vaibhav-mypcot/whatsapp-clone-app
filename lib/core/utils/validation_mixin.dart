mixin ValidationMixin {
  String? validatedName(String? value) {
    if (value == null || value.isEmpty || value.length >= 52) {
      return 'Please enter valid name';
    } else {
      //name regex
      // ignore: unnecessary_new
      RegExp regex = new RegExp(r'^[A-Za-z\ ]+$');
      if (!regex.hasMatch(value)) {
        return 'Name Should only contain alphabets';
      } else {
        return null;
      }
    }
  }

  String? validatedStatus(String? value) {
    if (value == null || value.isEmpty || value.length >= 52) {
      return 'Please enter valid name';
    } else {
      return null;
    }
  }
}
