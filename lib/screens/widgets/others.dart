import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Container saveButton({required String text}) {
  return Container(
    height: 50,
    width: 170,
    decoration: BoxDecoration(
        color: Colors.amber[200], borderRadius: BorderRadius.circular(20)),
    child: Center(
        child: Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
    )),
  );
}

class Ktextfield extends StatelessWidget {
  const Ktextfield(
      {super.key,
      required this.namecontroller,
      required this.hintText,
      required this.errorMsg,
      required this.kIcon,
      required this.type,
      required this.limit});

  final TextEditingController namecontroller;
  final String hintText;
  final String errorMsg;
  final IconData kIcon;
  final TextInputType type;
  final bool limit;
  @override
  Widget build(BuildContext context) {
    return limit == true
        ? WithLength(
            namecontroller: namecontroller,
            type: type,
            kIcon: kIcon,
            hintText: hintText,
            errorMsg: errorMsg)
        : TextFormField(
            controller: namecontroller,
            keyboardType: type,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  kIcon,
                  color: Colors.amber[200],
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: hintText),
            validator: (value) {
              if (value!.isEmpty) {
                return errorMsg;
              }
              return null;
            },
          );
  }
}

class WithLength extends StatelessWidget {
  const WithLength({
    super.key,
    required this.namecontroller,
    required this.type,
    required this.kIcon,
    required this.hintText,
    required this.errorMsg,
  });

  final TextEditingController namecontroller;
  final TextInputType type;
  final IconData kIcon;
  final String hintText;
  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 10,
      controller: namecontroller,
      keyboardType: type,
      decoration: InputDecoration(
          prefixIcon: Icon(
            kIcon,
            color: Colors.amber[200],
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: hintText),
      validator: (value) {
        if (value!.isEmpty) {
          return errorMsg;
        }
        return null;
      },
    );
  }
}
