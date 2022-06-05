import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/models/models.dart';
import 'package:univalle_app/theme/theme.dart';

class DocumentListItem extends StatelessWidget {
  const DocumentListItem(this.document, {Key? key}) : super(key: key);

  final Document document;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          document.quantity.toString(),
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          document.name,
          style: Theme.of(context).textTheme.headline3,
        ),
        if (document.deliveryDate != DateTime(0))
          Text(
            'Recibido el ${document.deliveryDate.day}/${document.deliveryDate.month}/${document.deliveryDate.year}',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AppColors.gray),
          ),
        if (document.expirationDate != DateTime(0))
          Text(
            'Vence el ${document.expirationDate.day}/${document.expirationDate.month}/${document.expirationDate.year}',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AppColors.gray),
          ),
        Row(
          children: [
            if (document.deliveryDate == DateTime(0))
              const _OutstandingDocumentChip()
            else
              const _DeliveredDocumentChip(),
            const SizedBox(width: 6),
            Chip(
              label: Text(document.required ? 'Obligatorio' : 'Complementario'),
            ),
          ],
        )
      ],
    );
  }
}

class _DeliveredDocumentChip extends StatelessWidget {
  const _DeliveredDocumentChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Entregado'),
          const SizedBox(width: 4),
          const Icon(
            MdiIcons.checkCircleOutline,
            color: AppColors.white,
            size: 18,
          ),
        ],
      ),
      backgroundColor: AppColors.green,
      labelStyle: Theme.of(context)
          .textTheme
          .overline!
          .copyWith(color: AppColors.white),
    );
  }
}

class _OutstandingDocumentChip extends StatelessWidget {
  const _OutstandingDocumentChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Pendiente'),
          const SizedBox(width: 4),
          const Icon(
            MdiIcons.checkCircleOutline,
            color: AppColors.white,
            size: 18,
          ),
        ],
      ),
      backgroundColor: AppColors.shiraz.shade300,
      labelStyle: Theme.of(context)
          .textTheme
          .overline!
          .copyWith(color: AppColors.white),
    );
  }
}
