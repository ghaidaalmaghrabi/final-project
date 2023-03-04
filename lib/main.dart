import 'package:final_project/pages/my_app.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://yotlqkmiarvqretmjmjm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlvdGxxa21pYXJ2cXJldG1qbWptIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzc3ODYyMzcsImV4cCI6MTk5MzM2MjIzN30.i0sgXe6IfQIp_xuuEvqYGbX_eGd0Sa4Pxq3vQm51Z8M',
  );
  runApp(const MyApp());
}
