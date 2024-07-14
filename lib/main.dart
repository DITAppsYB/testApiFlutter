import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testapi/data.dart';
import 'package:testapi/song.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepoListScreen(),
      );
  }
}

/*class RepoListScreen extends StatefulWidget {
  @override
  _RepoListScreenState createState() => _RepoListScreenState();
}

class _RepoListScreenState extends State<RepoListScreen> {
  late Future<List<Repo>> futureRepos;

  @override
  void initState() {
    super.initState();
    futureRepos = fetchRepos();
  }

  Future<List<Repo>> fetchRepos() async {
    final response = await http.get(Uri.parse('https://api.github.com/users/flutter/repos'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((repo) => Repo.fromJson(repo)).toList();
    } else {
      throw Exception('Failed to load repos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Repos'),
      ),
      body: FutureBuilder<List<Repo>>(
        future: futureRepos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No repos found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Repo repo = snapshot.data![index];
                return ListTile(
                  title: Text(repo.name),
                  subtitle: Text(repo.description),
                  onTap: () => launch(repo.html_url),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Repo {
  final String name;
  final String description;
  final String html_url;

  Repo({required this.name, required this.description, required this.html_url});

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      name: json['name'],
      description: json['description'] ?? '',
      html_url: json['html_url'],
    );
  }
}

void launch(String url) async {
  if (await canLaunch(url)) {
    launch(url);
  } else {
    throw 'Could not launch $url';
  }
}*/

class RepoListScreen extends StatefulWidget {
  @override
  _RepoListScreenState createState() => _RepoListScreenState();
}

class _RepoListScreenState extends State<RepoListScreen> {
  late Future<Data> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<Data> fetchData() async {
    final response = await http.get(Uri.parse('https://raw.githubusercontent.com/MenRiko/chab-billal/main/bilal.json'));

    if (response.statusCode == 200) {
      return Data.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cheb Bilal Songs'),
      ),
      body: FutureBuilder<Data>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.songs == null || snapshot.data!.songs!.isEmpty) {
            return Center(child: Text('No songs found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.songs!.length,
              itemBuilder: (context, index) {
                Song song = snapshot.data!.songs![index];
                return ListTile(
                  leading: song.image != null ? Image.network(song.image!) : null,
                  title: Text(song.songName ?? 'Unknown'),
                  subtitle: Text(song.artist ?? 'Unknown'),
                  onTap: song.songLink != null ? () => _launchURL(song.songLink!) : null,
                );
              },
            );
          }
        },
      ),
    );
  }
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


