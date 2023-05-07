import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EstimatedCost extends StatelessWidget {
  const EstimatedCost({super.key, required this.service});

  final DocumentSnapshot service;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(
                flex: 3,
                child: Text(
                  'Items',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sansita'),
                )),
            Expanded(
                flex: 2,
                child: Text(
                  'Quantity',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sansita'),
                )),
            Expanded(
                child: Text(
              'Cost',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Sansita'),
            )),
          ],
        ),
        const Divider(
          thickness: 0.4,
          color: Colors.black54,
        ),
        rowTiles('Labour', service.get('labourQty'),
            cost: service.get('labourCost')),
        rowTiles('Location', '${service.get('location')}', cost: ''),
        rowTiles('Paint', '${service.get('paintQty')} gillons',
            cost: service.get('paintCost')),
        rowTiles('Wall Cleaner', service.get('wallCleanerQty'),
            cost: service.get('wallCleanerCost')),
        rowTiles('Painter\'s tape', service.get('tapeQty'),
            cost: service.get('tapeCost')),
        rowTiles('Brushes', service.get('brushQty'),
            cost: service.get('brushCost')),
        rowTiles('Wall Area', '${service.get('wallQty')}sqft', cost: '/'),
        rowTiles('Door Area', '${service.get('doorQty')}sqft', cost: '/'),
        rowTiles('Window Area', '${service.get('windowQty')}sqft', cost: '/'),
      ],
    );
  }

  rowTiles(String name, String result, {String? cost}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sansita'),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            result,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sansita'),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            cost ?? '',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sansita'),
          ),
        ),
      ],
    );
  }
}
