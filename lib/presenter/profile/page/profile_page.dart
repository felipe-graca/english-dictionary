import 'dart:convert';
import 'dart:io';

import 'package:english_dictionary/core/feature/auth/cubit/auth_cubit.dart';
import 'package:english_dictionary/core/feature/user_details/cubit/user_details_cubit.dart';
import 'package:english_dictionary/core/routes/app_router.dart';
import 'package:english_dictionary/core/routes/app_routes.dart';
import 'package:english_dictionary/presenter/profile/widgets/custom_image_profile.dart';
import 'package:english_dictionary/presenter/profile/widgets/custom_logout_modal.dart';
import 'package:english_dictionary/ui/global/buttons/buttons.dart';
import 'package:english_dictionary/ui/global/custom_card/custom_card.dart';
import 'package:english_dictionary/ui/global/custom_loading_animation/custom_loading_animation.dart';
import 'package:english_dictionary/ui/global/custom_text_field/custom_text_field.dart';
import 'package:english_dictionary/ui/global/modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userDetailsCubit = GetIt.I.get<UserDetailsCubit>();
  final authCubit = GetIt.I.get<AuthCubit>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  void initializeControllers() {
    nameController.text = userDetailsCubit.state.userDetails.name;
    emailController.text = userDetailsCubit.state.userDetails.email;
  }

  void unFocus() {
    nameFocusNode.unfocus();
    emailFocusNode.unfocus();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: GoogleFonts.lato(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.98,
                      color: const Color.fromRGBO(102, 106, 214, 0.59),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await openModalBottomSheet(
                        context: context,
                        child: CustomLogoutModal(
                          logout: () async {
                            final logout = await authCubit.logout();
                            if (logout == true) {
                              if (!mounted) return;
                              Navigator.of(AppRouter.authNavigatorKey.currentState!.context)
                                  .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
                            }
                          },
                        ),
                      );
                    },
                    child: const Icon(Icons.logout, color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(child: CustomCard(child: _buildBody)),
          ],
        ),
      ),
    );
  }

  Widget get _buildBody {
    return BlocBuilder<UserDetailsCubit, UserDetailsState>(
      bloc: userDetailsCubit,
      builder: (context, state) {
        if (state.loading) {
          return const Center(
            child: CustomLoadingAnimation(),
          );
        }
        return Stack(
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 20),
                CustomImageProfile(
                  imageFile: _imageFileFromBase64(state.userDetails.base64Image),
                  onTap: () {
                    userDetailsCubit.pickImage();
                  },
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2, bottom: 5),
                        child: Text(
                          'Full name',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.98,
                            color: const Color(0xFF515151),
                          ),
                        ),
                      ),
                      CustomTextField(
                        controller: nameController,
                        focusNode: nameFocusNode,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2, bottom: 5),
                        child: Text(
                          'E-mail',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.98,
                            color: const Color(0xFF515151),
                          ),
                        ),
                      ),
                      CustomTextField(
                        controller: emailController,
                        focusNode: emailFocusNode,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    children: [
                      Text(
                        "Count of all new viewed words: ",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.98,
                          color: const Color(0xFF515151),
                        ),
                      ),
                      Text(
                        "${state.userDetails.countWords}",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.98,
                          color: const Color.fromARGB(255, 24, 0, 241),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
                child: SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        label: 'Configurations',
                        fullWidth: true,
                        leftIcon: Icons.settings,
                        onTap: () {},
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  //Base64 to file
  File? _imageFileFromBase64(String? base64) {
    if (base64 == null || base64.isEmpty) {
      return null;
    }
    final bytes = base64Decode(base64);
    final tempDir = Directory.systemTemp;
    final file = File('${tempDir.path}/image.jpg');
    file.writeAsBytesSync(bytes);
    return file;
  }
}
