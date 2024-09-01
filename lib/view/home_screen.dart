import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippet_technology_assignment/controller/movie_api_service.dart';
import 'package:clippet_technology_assignment/model/movie_item.dart';
import 'package:clippet_technology_assignment/view/screens/auth_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        elevation: 0,
        title: Obx(
          () => Text(
            'Hii ${authController.user.value?.name}',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<String>(
            iconColor: Colors.white,
            color: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Company Info',
                onTap: () {
                  showCompanyInfo(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Company Info"),
                    Icon(
                      Icons.info,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                onTap: () {
                  authController.logout();
                  Get.off(() => const LoginScreen());
                  Get.snackbar("Logout success", "",
                      backgroundColor: Colors.transparent,
                      colorText: Colors.white);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Logout"),
                    Icon(
                      Icons.logout,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<MovieItem>>(
        future: MovieApi().getMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text("Please Check Your Internet Connection"),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            print(snapshot.data);
            return const Center(
              child: Text("No Movies Available Right Now"),
            );
          }
          if (!snapshot.hasData) {
            print(snapshot.data);
            return const Center(
              child: Text("No Movies Available Right Now"),
            );
          }
          List<MovieItem> movieList = snapshot.data ?? [];
          return ListView.separated(
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(),
            itemCount: movieList.length,
            itemBuilder: (context, index) {
              var movie = movieList[index];
              return _buildMovieItem(
                  title: movie.title ?? "",
                  genre: movie.genre ?? 'Action,Adventure,Thriller',
                  director: movie.director?.firstOrNull ?? 'Cary Joji Fukunaga',
                  starring: movie.stars?.firstOrNull ?? 'Ana de Armas,Rami ...',
                  releaseInfo:
                      'Mins | ${movie.language} | ${movie.releasedDate}',
                  views: "${movie.pageViews ?? 137} views",
                  votes: 'Voted by ${movie.totalVoted} People',
                  imageUrl: movie.poster ?? 'https://example.com/bond25.jpg',
                  totlalVotings: movie.totalVoted?.toString() ?? "1");
            },
          );
        },
      ),
    );
  }

  Widget _buildMovieItem({
    required String title,
    required String genre,
    required String director,
    required String starring,
    required String releaseInfo,
    required String views,
    required String votes,
    required String imageUrl,
    required String totlalVotings,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_drop_up,
                        color: Colors.black,
                        size: 50,
                      )),
                  Text(totlalVotings,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 50,
                      )),
                  const Text("Votes")
                ],
              ),
              const SizedBox(width: 8),
              PhysicalModel(
                color: Colors.transparent,
                elevation: 10,
                borderRadius: BorderRadius.circular(7),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: CachedNetworkImage(
                      imageUrl: imageUrl,
                    width: 85,
                    height: 130,
                    errorWidget: (context, url, error) => Center(child: Icon(Icons.error),),
                    placeholder: (context, url) => Center(child: CupertinoActivityIndicator(),),
                  ),
                  // Image.network(
                  //   imageUrl,
                  //   width: 85,
                  //   height: 130,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text('Genre: $genre'),
                    Text('Director: $director'),
                    Text('Starring: $starring'),
                    Text(releaseInfo),
                    SizedBox(height: 4),
                    Text('$views | $votes',
                        style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Watch Trailer',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              minimumSize: Size(double.infinity, 36),
            ),
          ),
        ],
      ),
    );
  }

  void showCompanyInfo(BuildContext context) {
    Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 350,
        height: 270,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Company Info",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            fieldView(
                name: "Company: ", value: "Geeksynergy Technologies Pvt Ltd"),
            fieldView(name: "Address: ", value: "Sanjayanagar, Bengaluru-56"),
            fieldView(name: "Phone: ", value: "XXXXXXXXX09"),
            fieldView(name: "Email:", value: " XXXXXX@gmail.com"),
          ],
        ),
      ),
    ));
  }

  fieldView({required String name, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
              constraints: const BoxConstraints(minWidth: 80),
              child: Text(name)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
