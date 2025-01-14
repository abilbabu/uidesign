import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uidesign/utils/constants/app_style.dart';
import 'package:uidesign/utils/constants/color_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedGender = 'Undisclosed';
  String selectedMaritalStatus = 'Undisclosed';

  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.transparent,
        surfaceTintColor: ColorConstants.transparent,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 70,
                              ),
                              Positioned(
                                right: -2,
                                bottom: -2,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.person_add_alt,
                                    size: 30,
                                    color: ColorConstants.textcolor,
                                    weight: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Profile Details',
                            style: AppStyle.getTitleStyle(
                                fontSize: 18, color: ColorConstants.textcolor)),
                        const SizedBox(height: 10),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Full name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Mobile number',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 13),
                              child: Text(
                                '+91 ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            suffixIcon: TextButton(
                              onPressed: () {},
                              child: const Text('Verify'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Email address',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.mail_outline),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: 'Date of Birth',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () => _selectDate(context),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text('GENDER',
                            style: AppStyle.getTitleStyle(
                                fontSize: 16, color: ColorConstants.textcolor)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ChoiceChip(
                              label: Text('Male'),
                              selected: selectedGender == 'Male',
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedGender = 'Male';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text('Female'),
                              selected: selectedGender == 'Female',
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedGender = 'Female';
                                });
                              },
                            ),
                            ChoiceChip(
                              label: const Text('Undisclosed'),
                              selected: selectedGender == 'Undisclosed',
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedGender = 'Undisclosed';
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Text(
                            'Logout',
                            style: AppStyle.getTextStyle(
                                fontSize: 18, color: ColorConstants.textcolor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
