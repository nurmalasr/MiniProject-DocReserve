import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/user/user_bloc.dart';
import '../utils/colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton.icon(
              style: const ButtonStyle(
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
              ),
              onPressed: () {
                context.read<UserBloc>().add(SignOut());
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              label: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              var namaCtrl = TextEditingController(
                  text: state is UserSignedIn ? state.user.fullname : null);
              var tglCtrl = TextEditingController(
                  text: state is UserSignedIn ? state.user.tglLahir : null);
              var locCtrl = TextEditingController(
                  text: state is UserSignedIn ? state.user.location : null);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: grey,
                            width: 3,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://i.pinimg.com/236x/10/6a/a4/106aa400467ac3f9f748481911e3ebdd.jpg',
                            placeholder: (context, url) => const Icon(
                              Icons.people,
                              size: 100,
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.people,
                              size: 100,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Nama Lengkap',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: namaCtrl,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: primaryColor.withOpacity(0.6)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Tanggal lahir',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: tglCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: primaryColor.withOpacity(0.6)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryColor),
                        ),
                        suffixIcon: const Icon(
                          Icons.date_range,
                          color: primaryColor,
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: state is UserSignedIn
                              ? DateTime.parse(state.user.tglLahir)
                              : DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        tglCtrl.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate!);
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Tempat tinggal',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: locCtrl,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: primaryColor.withOpacity(0.6)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(primaryColor),
                      ),
                      onPressed: () {
                        context.read<UserBloc>().add(
                              UpdateUser(
                                fullname: namaCtrl.text,
                                tglLahir: tglCtrl.text,
                                location: locCtrl.text,
                              ),
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Data berhasil diedit"),
                          ),
                        );
                      },
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: white,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
