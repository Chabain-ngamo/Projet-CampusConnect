import 'package:campus_connect/controllers/profilSearchController.dart';
import 'package:campus_connect/models/userModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/providers/user_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/chat_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    searchController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    usersProvider.fetchUsers();
    super.initState();
  }

  List<UserModel> listUsersSearch = [];

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;

    return Scaffold(
      backgroundColor: colorB,
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(59, 158, 158, 158),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        focusNode: _searchTextFocusNode,
                        onChanged: (valuee) {
                          setState(() {
                            listUsersSearch = usersProvider.searchQuery(valuee);
                          });
                        },
                        decoration:  InputDecoration(
                          hintText: AppLocalizations.of(context)!.searhM,
                          hintStyle: TextStyle(
                              fontSize: 18,
                              fontFamily: 'CrimsonText',
                              color: Colors.grey),
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.cancel_rounded,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        searchController.clear();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          searchController.text.isNotEmpty && listUsersSearch.isNotEmpty
              ? 
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listUsersSearch.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: listUsersSearch[index],
                      child: const ProfilSearchController(),
                    );
                  },
                ) : 
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 400.0,
                      child: Image.asset(
                        'assets/founduser.png',
                      ),
                    ),
                  ),
                ],
              ) 
        ],
      ),
    ));
  }
}
