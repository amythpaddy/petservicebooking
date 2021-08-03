import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookBloc.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookState.dart';
import 'package:the_pet_nest/funnels/component/addLocationComponent.dart';
import 'package:the_pet_nest/funnels/component/selectLocationComponent.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/utils/utils.dart';

class AddressList extends StatelessWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Service Address',
          style: kAppBarTitleStyle,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kAppBackgroundColor,
      ),
      backgroundColor: kAppBackgroundColor,
      body: BlocProvider(
        create: (_) => AddressBookBloc(initialState: AddressBookState()),
        child: BlocBuilder<AddressBookBloc, AddressBookState>(
          builder: (blocContext, state) {
            return Column(children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: state.savedAddresses?.data.length,
                      itemBuilder: (context, index) {
                        String city = state.savedAddresses!.data[index].city;
                        String address1 =
                            state.savedAddresses!.data[index].address1;
                        return (Dismissible(
                          key: Key('$city$address1'),
                          // direction: DismissDirection.endToStart,
                          onDismissed: (direction) => showSnackbar(
                              context: context, message: 'Content Deleted'),
                          background: Container(
                            padding: EdgeInsets.only(right: 36),
                            color: kAppBackgroundAltGray,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete_outline_rounded,
                                  color: kAppIconColor,
                                )),
                          ),
                          child: SelectLocationComponent(
                            city: city,
                            address: address1,
                          ),
                        ));
                      })),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, kNavigationAddEditAddressBook);
                      },
                      child: AddLocationComponent(
                        backgroundColor: kAppIconColor,
                        textColor: Colors.white,
                      ))),
              SizedBox(
                height: 40,
              )
            ]);
          },
        ),
      ),
    );
  }
}
