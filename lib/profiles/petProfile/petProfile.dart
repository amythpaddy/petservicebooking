import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';
import 'package:the_pet_nest/profiles/petProfile/component/petInfo.dart';
import 'package:the_pet_nest/profiles/petProfile/model/editPetArguments.dart';

class PetProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditPetArguments args =
        ModalRoute.of(context)!.settings.arguments as EditPetArguments;
    return Scaffold(
      backgroundColor: kAppBackgroundAltGray,
      appBar: AppBar(
        backgroundColor: kAppBackgroundAltGray,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pet Profile',
          style: kAppBarTitleStyle,
        ),
      ),
      body: BlocProvider(
        create: (_) => PetProfileBloc(PetProfileState()),
        child: BlocListener<PetProfileBloc, PetProfileState>(
          listener: (blocListenerContext, state) {
            if (state.addUpdatePet == null && !state.fetchingPetData) {
              BlocProvider.of<PetProfileBloc>(blocListenerContext)
                  .getSinglePetData(args.petId);
            }
          },
          child: BlocBuilder<PetProfileBloc, PetProfileState>(
            builder: (blocContext, state) {
              if (state.fetchingPetData || state.addUpdatePet == null) {
                return Center(
                  child: CircularProgressIndicator(
                    color: kAppIconColor,
                  ),
                );
              } else {
                String aggression = 'High';
                if (state.addUpdatePet!.aggression == Aggression.LOW)
                  aggression = 'Low';
                else if (state.addUpdatePet!.aggression == Aggression.MEDIUM)
                  aggression = 'Medium';
                return Container(
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [kContainerBoxShadow],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              state.addUpdatePet!.image.isEmpty
                                  ? SvgPicture.asset(
                                      state.addUpdatePet!.petCategory ==
                                              PetCategory.DOG
                                          ? 'assets/images/dog_avatar.svg'
                                          : 'assets/images/cat_avatar.svg',
                                      height: 72,
                                      width: 72,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(36),
                                      child: Image.network(
                                        state.addUpdatePet!.image,
                                        height: 72,
                                        width: 72,
                                        fit: BoxFit.fitWidth,
                                      )),
                              SizedBox(
                                width: 9,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.addUpdatePet!.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        height: 1.5),
                                  ),
                                  Text(
                                    state.addUpdatePet!.subCategory!.name,
                                    style: TextStyle(
                                        color: kTextColorBlue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.5),
                                  )
                                ],
                              )),
                              SizedBox(
                                width: 9,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                            context, kNavigationEditPetProfile,
                                            arguments: args)
                                        .whenComplete(() =>
                                            BlocProvider.of<PetProfileBloc>(
                                                    blocContext)
                                                .getSinglePetData(args.petId));
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/profile/edit.svg',
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 9.25,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [kContainerBoxShadow],
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PetInfo(
                                heading: 'Gender',
                                value: state.addUpdatePet!.gender == Gender.MALE
                                    ? 'Male'
                                    : 'Female',
                              ),
                              Divider(
                                height: 1,
                              ),
                              PetInfo(
                                heading: 'Age',
                                value: '${state.addUpdatePet!.age} years',
                              ),
                              Divider(
                                height: 1,
                              ),
                              PetInfo(
                                heading: 'Weight',
                                value: '${state.addUpdatePet!.weight} Kg',
                              ),
                              Divider(
                                height: 1,
                              ),
                              PetInfo(
                                heading: 'Aggression',
                                value: aggression,
                              ),
                              Divider(
                                height: 1,
                              ),
                              PetInfo(
                                heading: 'Vaccinated',
                                value: state.addUpdatePet!.vaccine == 1
                                    ? 'Yes'
                                    : 'No',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 250,
                        ),
                        Center(
                          child: Text(
                            'Version ${state.appVersion}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.5),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
