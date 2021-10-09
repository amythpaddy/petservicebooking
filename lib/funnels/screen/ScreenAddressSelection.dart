import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookBloc.dart';
import 'package:the_pet_nest/addressBook/bloc/addressBookState.dart';
import 'package:the_pet_nest/addressBook/components/noSavedAddressComponent.dart';
import 'package:the_pet_nest/addressBook/model/addressBookModel.dart';
import 'package:the_pet_nest/config/sizeConfig.dart';
import 'package:the_pet_nest/funnels/component/selectLocationComponent.dart';
import 'package:the_pet_nest/funnels/interfaces/AddressSelectionInterface.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/konstants/styles.dart';

import '../component/addLocationComponent.dart';

class ScreenAddressSelection extends StatelessWidget {
  const ScreenAddressSelection({Key? key, required this.onAddressSelection})
      : super(key: key);
  final AddressSelectionInterface onAddressSelection;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 18.46),
          child: BlocListener<AddressBookBloc, AddressBookState>(
              listener: (blocContext, state) {
            if (state.openAddEditAddressScreen) {
              Navigator.pushNamed(context, kNavigationAddEditAddressBook).then(
                  (value) => BlocProvider.of<AddressBookBloc>(blocContext)
                      .getSavedAddress());
            }
          }, child: BlocBuilder<AddressBookBloc, AddressBookState>(
            builder: (blocContext, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60.89,
                  ),
                  Text(
                    'Select City',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16, height: 1.5),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  state.cityList == null
                      ? CircularProgressIndicator()
                      : Container(
                          width: SizeConfig.blockSizeHorizontal * 90,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: DropdownSearch<CityDetail>(
                            dropdownSearchDecoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 2, 0, 0),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0x331A202E)),
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            mode: Mode.DIALOG,
                            showSelectedItem: true,
                            items: state.cityList!.cityList,
                            itemAsString: (cityData) => cityData.cityName,
                            hint: "Select a city",
                            onChanged: (cityDetail) {
                              onAddressSelection.onAddressSelected(
                                  blocContext, null);
                              BlocProvider.of<AddressBookBloc>(blocContext)
                                  .addressSelectedByUser(-1);
                              if (cityDetail == null) {
                                BlocProvider.of<AddressBookBloc>(blocContext)
                                    .getSavedAddress();
                              } else {
                                BlocProvider.of<AddressBookBloc>(blocContext)
                                    .filterAddress(cityDetail);
                              }
                            },
                            compareFn: (i, s) {
                              return true;
                            },
                            showSearchBox: true,
                            showClearButton: true,
                          )),
                  SizedBox(
                    height: 27.1,
                  ),
                  Text(
                    state.addressBook == null ? '' : 'Address',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16, height: 1.5),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: state.fetchingAddressBook
                        ? Center(
                            child: Container(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator()))
                        : state.addressBook == null ||
                                state.addressBook!.address.length == 0
                            ? Center(child: NoSavedAddress())
                            : ListView.builder(
                                itemCount: state.addressBook!.address.length,
                                itemBuilder: (context, index) => TextButton(
                                    onPressed: () {
                                      onAddressSelection.onAddressSelected(
                                          blocContext,
                                          state.addressBook!.address[index]);
                                      BlocProvider.of<AddressBookBloc>(
                                              blocContext)
                                          .addressSelectedByUser(index);
                                    },
                                    child: SelectLocationComponent(
                                      city: state
                                          .addressBook!.address[index].city,
                                      address: state.addressBook!.address[index]
                                          .addressLineOne,
                                      selected:
                                          index == state.selectedAddressIndex,
                                    ))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextButton(
                      onPressed: () =>
                          BlocProvider.of<AddressBookBloc>(blocContext)
                              .openAddAddress(),
                      child: AddLocationComponent(
                        backgroundColor: Colors.white,
                        textColor: kAppIconColor,
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  TextButton(
                    child: Container(
                        alignment: Alignment.center,
                        decoration: kActiveButtonContainerStyle,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Next',
                          style: kActiveButtonTextStyle,
                        )),
                    onPressed: () {
                      onAddressSelection
                          .onAddressSelectionComplete(blocContext);
                    },
                  ),
                  SizedBox(
                    height: 63,
                  )
                ],
              );
            },
          ))),
    );
  }
}
