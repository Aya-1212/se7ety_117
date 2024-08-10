import 'package:cloud_firestore/cloud_firestore.dart';

class AppoinmnetServices {
static Future<String>  getAppoinmentID(
      {required String doctorId,
      required String patientId,
      required Timestamp date}) async {
    // get all documents
    var querySnapshots = await FirebaseFirestore.instance
        .collection("appoinment")
        .doc("appoinments")
        .collection("all")
        .get();

    //loop
    for (int i = 0; i < querySnapshots.docs.length; i++) {
      //get each document
      var document = querySnapshots.docs[i];

      var snapshot = await FirebaseFirestore.instance
          .collection("appoinment")
          .doc("appoinments")
          .collection("all")
          .doc(document.id)
          .get();

      if (snapshot.data()!.containsValue(doctorId) &&
          snapshot.data()!.containsValue(patientId) &&
          snapshot.data()!.containsValue(date)) {
        return document.id;
      }
    }
    return ""; 
  }

static   deleteAppoinment(String docId) {
    FirebaseFirestore.instance
        .collection("appoinment")
        .doc("appoinments")
        .collection("pending")
        .doc(docId)
        .delete();
  }



}
