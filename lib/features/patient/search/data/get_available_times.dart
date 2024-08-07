class AppointmentsServices {
  Future<List<int>> availableAppoinmentsTimes({
    required String openHour,
    required String endHour,
    required DateTime dateSelected,
  }) async {
    int start = int.parse(openHour);
    int end = int.parse(endHour);

    List<int> allTimesAvailable = [];

    for (int i = start; i < end; i++) {
      DateTime candidateTime = DateTime(
        dateSelected.year,
        dateSelected.month,
        dateSelected.day,
        i,
      );

      if (candidateTime.day != DateTime.now().day) {
        allTimesAvailable.add(candidateTime.hour);
      }
      if (candidateTime.hour > DateTime.now().hour &&
          candidateTime.day == DateTime.now().day &&
           candidateTime.year == DateTime.now().year
          ) {
        allTimesAvailable.add(candidateTime.hour);
      }
    }

    return allTimesAvailable;
  }
}
