import 'package:flutter/material.dart';

class EstimatedCost extends StatelessWidget {
  const EstimatedCost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(flex: 3, child: Text('Items',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Sansita'),)),
            Expanded(flex: 2, child: Text('Quantity',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Sansita'),)),
            Expanded(child: Text('Cost',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Sansita'),)),
          ],
        ),
        const Divider(
          thickness: 0.4,
          color: Colors.black54,
        )
      ],
    );
  }

  calculateRowTiles(String name, String result){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sansita'),
          ),
          const Spacer(),
          Text(
            result,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sansita'),
          ),
        ],
      ),
    );
  }

}