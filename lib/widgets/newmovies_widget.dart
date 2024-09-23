import 'package:flutter/material.dart';
import 'package:nova/pages/movie_page.dart';

class NewmoviesWidget extends StatefulWidget {
  const NewmoviesWidget({super.key});

  @override
  State<NewmoviesWidget> createState() => _NewmoviesWidgetState();
}

class _NewmoviesWidgetState extends State<NewmoviesWidget> {
  // Sample movie data - replace this with your actual data source
  final List<Map<String, dynamic>> movies = [
    {
      'title': 'Doctor Strange 2',
      'genre': 'Action/Adventure',
      'rating': 8.5,
      'image': 'lib/images/1.png',
      'description':
          'Doctor Strange faces off against a multiverse of Champions...'
    },
    {
      'title': 'Avengers',
      'genre': 'Action/Adventure',
      'rating': 8.5,
      'image': 'lib/images/2.png',
      'description':
          'Doctor Strange faces off against a multiverse of Champions...'
    },
    {
      'title': 'Black Panther',
      'genre': 'Action/Adventure',
      'rating': 8.5,
      'image': 'lib/images/3.png',
      'description':
          'Doctor Strange faces off against a multiverse of Champions...'
    },
    {
      'title': 'Shnag chi',
      'genre': 'Action/Adventure',
      'rating': 8.5,
      'image': 'lib/images/4.png',
      'description':
          'Doctor Strange faces off against a multiverse of Champions...'
    },
    {
      'title': 'Ant-Man',
      'genre': 'Action/Adventure',
      'rating': 8.5,
      'image': 'lib/images/5.png',
      'description':
          'Doctor Strange faces off against a multiverse of Champions...'
    },
    {
      'title': 'Loki',
      'genre': 'Action/Adventure',
      'rating': 8.5,
      'image': 'lib/images/6.png',
      'description':
          'Doctor Strange faces off against a multiverse of Champions...'
    },
    {
      'title': 'Thor - ragnarok',
      'genre': 'Action/Adventure',
      'rating': 8.5,
      'image': 'lib/images/7.png',
      'description':
          'Doctor Strange faces off against a multiverse of Champions...'
    },
    {
      'title': 'spider-man',
      'genre': 'Action/Adventure',
      'rating': 8.5,
      'image': 'lib/images/8.png',
      'description':
          'Doctor Strange faces off against a multiverse of Champions...'
    },
    {
      'title': 'venom',
      'genre': 'Action/Adventure',
      'rating': 8.5,
      'image': 'lib/images/9.png',
      'description':
          'Doctor Strange faces off against a multiverse of Champions...'
    },
    {
      'title': 'Doctor Strange 2',
      'genre': 'Action/Adventure',
      'rating': 8.5,
      'image': 'lib/images/10.png',
      'description':
          'Doctor Strange faces off against a multiverse of Champions...'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'New Movies',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var movie in movies)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoviePage(movie: movie),
                      ),
                    );
                  },
                  child: Container(
                    width: 190,
                    height: 300,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.asset(
                            movie['image'],
                            height: 194,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie['title'],
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                movie['genre'],
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    movie['rating'].toString(),
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
