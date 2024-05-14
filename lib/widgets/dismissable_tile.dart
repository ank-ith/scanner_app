import 'dart:ui';

import 'package:flutter/material.dart';

class DismissTile extends StatelessWidget {
  final String name;
  final String companyName;
  final String image;
  final bool isPinned;

  const DismissTile(
      {super.key,
      required this.name,
      required this.companyName,
      required this.image,
      this.isPinned = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz2qTSTCcHgfn2T_Nv7xlY50wQn0xkX-CntQ&s'),
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              fit: BoxFit.cover)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/564x/76/f8/0c/76f80c03ec446cb4499c565d749b7b2b.jpg'),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      companyName,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          Column(
            children: [
              isPinned
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notes,
                        size: 30,
                        color: Colors.white,
                      ))
                  : const SizedBox(
                      height: 50,
                    ),
              ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.download_outlined),
              )
            ],
          ),
        ],
      ),
    );
  }
}
