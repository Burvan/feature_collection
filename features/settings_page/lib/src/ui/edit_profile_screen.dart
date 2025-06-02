import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  final User user;
  final ValueChanged<User> onSave;

  const EditProfileScreen({
    required this.user,
    required this.onSave,
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  Uint8List? _newAvatar;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Uint8List bytes = await pickedFile.readAsBytes();

      setState(() {
        _newAvatar = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.settings_editUserData.watchTr(context),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                widget.onSave(
                  widget.user.copyWith(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    avatar: () => _newAvatar,
                  ),
                );
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage,
              child: Hero(
                tag: widget.user.id,
                child: CircleAvatar(
                  radius: size.width / 4,
                  backgroundColor: themeData.primaryColor,
                  backgroundImage: _newAvatar != null
                      ? MemoryImage(_newAvatar!)
                      : (widget.user.avatar != null
                          ? MemoryImage(widget.user.avatar!)
                          : null),
                  child: _newAvatar == null && widget.user.avatar == null
                      ? const Icon(Icons.add_a_photo, size: 30)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    controller: _firstNameController,
                    labelText: LocaleKeys.auth_firstName.watchTr(context),
                    icon: const Icon(Icons.person_outline),
                    validator: (String? value) => Validators.nameValidator(
                      value,
                      context,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _lastNameController,
                    labelText: LocaleKeys.auth_lastName.watchTr(context),
                    icon: const Icon(Icons.person_outline),
                    validator: (String? value) => Validators.nameValidator(
                      value,
                      context,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    labelText: LocaleKeys.auth_emailAddress.watchTr(context),
                    icon: const Icon(Icons.email_outlined),
                    keyBoardType: TextInputType.emailAddress,
                    validator: (String? value) => Validators.emailValidator(
                      value,
                      context,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
