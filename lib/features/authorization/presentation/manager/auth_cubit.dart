import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se7ety_117/features/authorization/presentation/manager/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  registerAsDoctor(
      {required String userEmail,
      required String userPassword,
      required String userName}) async {
    emit(RegisterLoadingState());

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);
      User user = credential.user!;
      user.updateDisplayName(userName);
      //FirebaseAuth.instance.currentUser!.updateDisplayName(userName);
       FirebaseFirestore.instance.collection('doctors').doc(user.uid).set({
        'name': userName,
        'email': user.email,
        'uid': user.uid,
        'phone1': '',
        'phone2': '',
        'bio': '',
        'openHour': '',
        'closeHour': '',
        'address': '',
        'image': '',
        'specialization': '',
        'rating': 3,
      }, SetOptions(merge: true));
      emit(RegisterSuccessState());
    
    
    
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState(error: 'كلمة المرور ضعيفة جدًا'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState(error: 'البريد الالكتروني مستخدم من قبل'));
      } else {
        emit(RegisterErrorState(error: 'حدثت مشكله في التسجيل'));
      }
    } catch (e) {
      emit(RegisterErrorState(error: 'حدثت مشكلة في الانترنت'));
    }
  }

  registerAsPatient(
      {required String userEmail,
      required String userPassword,
      required String userName}) async {
    emit(RegisterLoadingState());

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);
      User user = credential.user!;
      user.updateDisplayName(userName);
      //FirebaseAuth.instance.currentUser!.updateDisplayName(userName);
       FirebaseFirestore.instance
          .collection('patients')
          .doc(user.uid)
          .set({
        'name': user.displayName,
        'email': user.email,
        'uid': user.uid,
        'phone': '',
        'bio': '',
        'city': '',
        'image': '',
        'age': '',
      }, SetOptions(merge: true));
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState(error: 'كلمة المرور ضعيفة جدًا'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState(error: 'البريد الالكتروني مستخدم من قبل'));
      } else {
        emit(RegisterErrorState(error: 'حدثت مشكله في التسجيل'));
      }
    } catch (e) {
      emit(RegisterErrorState(error: 'حدثت مشكلة في الانترنت'));
    }
  }

  login(
      {required String userEmail,
      required String userPassword,}) async {
      emit(LoginLoadingState());
      try {
         await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userEmail, password: userPassword);

        emit(LoginSuccessState());
      } on FirebaseAuthException catch (e) {
        if ( e.code == 'user-not-found')
        {
            emit(LoginErrorState(error: 'البريد الالكتروني غير موجود'));
        } else if ( e.code == 'wrong-password'){
            emit(LoginErrorState(error: 'كلمة المرور خاطئة'));
          } else{
            emit(LoginErrorState(error: 'حدثت مشكلة في التسجيل'));
          }
      } catch (e) {
        emit(LoginErrorState(error: 'حدثت مشكلة في الانترنت'));
              }
  }

  updateDoctorProfile(
  { required String uid ,
   required String address ,
  required String bio ,
  required String closeHour ,
  required String openHour ,
  required String phone1,
   String? phone2 ,
   required String image,
   required String specialization,}){
    emit(UpdateDoctorLoadingState());
   try{
 FirebaseFirestore.instance.collection('doctors').doc(uid).set({
      'address' : address,
      'bio': bio ,
      'closeHour': closeHour,
      'image': image,
      'openHour': openHour ,
      'phone1': phone1 ,
      'phone2': phone2  ,
      'specialization' : specialization ,
    },SetOptions(merge: true));
   emit(UpdateDoctorSuccessState());
   } catch (e){
     emit(UpdateDoctorErrorState(error: 'حدثت مشكلة في التعديل'));
   }
  }

  
}
