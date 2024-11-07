import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/common/widgets/show_upload_image_popup.dart';
import 'package:whatsapp_clone_app/core/constants/constants.dart';
import 'package:whatsapp_clone_app/feature/contacts/presentation/bloc/contact_list_bloc.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/pages/chat_screen.dart';

class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen({super.key});

  static const String route = '/contact_list_screen';

  @override
  State<ContactsListScreen> createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ContactListBloc>().add(ContactListCompareEvent());
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    context.read<ContactListBloc>().add(ContactListClearEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts List"),
      ),
      body: Column(
        children: [
          BlocBuilder<ContactListBloc, ContactListState>(
            builder: (context, state) {
              if (state is ContactListLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ContactListSuccessState) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.contactsOnApp.length,
                    itemBuilder: (context, index) {
                      final contact = state.contactsOnApp[index];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 50.r,
                          backgroundImage: FadeInImage(
                            height: 100.h,
                            width: 100.w,
                            image:
                                NetworkImage(contact['imageUrl'] ?? "No Name"),
                            placeholder:
                                const AssetImage(Constants.profileImage),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                Constants.profileImage,
                                fit: BoxFit.cover,
                                height: 100.h,
                                width: 100.w,
                              );
                            },
                            fit: BoxFit.cover,
                            placeholderFit: BoxFit.scaleDown,
                          ).image,
                        ),
                        title: Text(contact['name'] ?? "No Name"),
                        subtitle:
                            Text(contact['phoneNumber'] ?? 'No Phone Number'),
                        onTap: () {
                          // Implement onTap action here
                          Navigator.pushNamed(
                            context,
                            ChatScreen.route,
                            arguments: {
                              'receiverId': contact['reciverId'],
                              'name': contact['name'],
                              'imageUrl': contact['imageUrl'],
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
