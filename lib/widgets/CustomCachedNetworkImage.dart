
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatefulWidget{
  const CustomCachedNetworkImage({super.key, required this.url});

  final String url;

  @override
  State<StatefulWidget> createState() => _CustomCachedNetworkImageState();
}

class _CustomCachedNetworkImageState extends State<CustomCachedNetworkImage>{
  @override
  Widget build(BuildContext context){
    return CachedNetworkImage(placeholder: (context, url) => const CircularProgressIndicator(),
      imageUrl: widget.url,
      errorWidget: (context,url,error) => const Icon(Icons.error),
    );
  }
}