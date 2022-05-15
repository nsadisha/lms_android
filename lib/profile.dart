import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Text("Profile", style: Theme.of(context).textTheme.headline4,),
          SizedBox(height: 50,),
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage("https://picsum.photos/250?image=9")
                )
            ),
          ),
          SizedBox(height: 30,),
          Text("Sadisha Nimsara",style: Theme.of(context).textTheme.headline5),
          Text("nsadisha@gmail.com", style: Theme.of(context).textTheme.bodyMedium,),
          Expanded(child: Container(),),
          ElevatedButton(onPressed: (){print("Signout");}, child: Text("Signout"))
        ],
      ),
    );
  }
}