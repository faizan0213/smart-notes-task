import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/note_model.dart';

class FirestoreProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNote({
    required String title,
    required String message,
    required String userId,
  }) async {
    try {
      final note = NoteModel(
        id: '',
        title: title,
        message: message,
        userId: userId,
        timestamp: DateTime.now(),
      );
      await _firestore.collection('notes').add(note.toMap());
    } catch (e) {
      throw Exception("Failed to add note: $e");
    }
  }
   Future<void> deleteNote(String noteId) async {
    await _firestore.collection('notes').doc(noteId).delete();
    notifyListeners(); // Refresh UI
  }

  Stream<List<NoteModel>> getUserNotes(String userId) {
    return _firestore
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => NoteModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }
}
