import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookBloc.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookState.dart';
import 'package:the_pet_nest/addressBook/components/noSavedAddressComponent.dart';
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
        child: BlocListener<AddressBookBloc, AddressBookState>(
          listener: (blocContext, state) {
            if (state.openAddEditAddressScreen) {
              Navigator.pushNamed(context, kNavigationAddEditAddressBook).then(
                  (value) => BlocProvider.of<AddressBookBloc>(blocContext)
                      .getSavedAddress());
            }
          },
          child: BlocBuilder<AddressBookBloc, AddressBookState>(
            builder: (blocContext, state) {
              return Column(children: [
                state.fetchingAddressBook
                    ? Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ))
                    :Expanded(
                        child: state.addressBook == null ||
                                state.addressBook!.address.length == 0
                            ? NoSavedAddress()
                            : ListView.builder(
                                itemCount: state.addressBook!.address.length,
                                itemBuilder: (context, index) {
                                  String city =
                                      state.addressBook!.address[index].city;
                                  String address1 = state.addressBook!
                                      .address[index].addressLineOne;

                                  return (Dismissible(
                                    key: UniqueKey(),
                                    // direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      BlocProvider.of<AddressBookBloc>(
                                              blocContext)
                                          .deleteAddress(state
                                              .addressBook!.address[index].id);
                                      showSnackbar(
                                          context: context,
                                          message: 'Content Deleted');
                                    },
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
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                                kNavigationAddEditAddressBook,
                                                arguments: state.addressBook!
                                                    .address[index])
                                            .then((value) => BlocProvider.of<
                                                        AddressBookBloc>(
                                                    blocContext)
                                                .getSavedAddress());
                                      },
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.all(0)),
                                      child: SelectLocationComponent(
                                        city: city,
                                        address: address1,
                                      ),
                                    ),
                                  ));
                                })),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: TextButton(
                        onPressed: () =>
                            BlocProvider.of<AddressBookBloc>(blocContext)
                                .openAddAddress(),
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
      ),
    );
  }
}
