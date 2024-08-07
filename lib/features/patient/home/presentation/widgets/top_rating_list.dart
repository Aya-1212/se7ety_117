import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_117/core/widgets/doctor_card.dart';

class TopRatingDoctorsList extends StatelessWidget {
  const TopRatingDoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("doctors")
          .orderBy("rating", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doctor = snapshot.data!.docs[index];

              if (doctor['image'] == "" ||
                  doctor['specialization'] == "" ||
                  doctor['phone1'] == "") {
                return const SizedBox();
              }

              return DoctorCard(
                name: doctor['name'],
                image: doctor['image'],
                specialization: doctor['specialization'],
                rating: doctor['rating'],
                doctorEmail: doctor["email"],
              );
            },
          );
        }
      },
    );
  }
}
