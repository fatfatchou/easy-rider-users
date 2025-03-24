import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:users/core/global.dart';
import 'package:users/core/theme.dart';
import 'package:users/features/auth/presentation/widgets/custom_button.dart';
import 'package:users/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:users/features/profile/presentation/bloc/profile_event.dart';
import 'package:users/features/profile/presentation/bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(GetCurrentUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (state is ProfileLoadedState) {
          return Column(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar_user.png'),
                maxRadius: 50,
              ),
              const SizedBox(height: 24),
              Text(
                state.user.name,
                style: const TextStyle(
                  color: AppColors.contentTertiary,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.gray300,
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    child: Text(
                      state.user.email,
                      style: const TextStyle(
                        color: AppColors.contentSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.gray300,
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/vn-flag.svg',
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          '+84',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.contentPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          state.user.phone,
                          style: const TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    text: 'Sign out',
                    onPress: () {
                      firebaseAuth.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                  ),
                ),
              )
            ],
          );
        } else if (state is ProfileFailureState) {
          return Center(
            child: Text(state.message),
          );
        }
        return Container();
      },
    );
  }
}
