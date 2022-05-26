import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/models/procedure.dart';
import 'package:univalle_app/procedures/pages/procedures_page.dart';
import 'package:univalle_app/theme/app_colors.dart';

class ProceduteCardv2 extends StatefulWidget {
  final Procedure procedure;
  const ProceduteCardv2(this.procedure, {Key? key}) : super(key: key);

  @override
  State<ProceduteCardv2> createState() => _ProceduteCardv2State();
}

class _ProceduteCardv2State extends State<ProceduteCardv2> {
  IconData iconData = MdiIcons.chevronDown;
  IconData iconData2 = MdiIcons.chevronUp;
  @override
  Widget build(BuildContext context) {
    //IconData iconDataAux = iconData;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.procedure.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.procedure.estimatedDays} dias estimados',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AppColors.gray),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Chip(
                      label: Text(
                        widget.procedure.requiresInvoice
                            ? 'Precisa factura'
                            : 'No precisa factura',
                        style: Theme.of(context).textTheme.overline,
                      ),
                      backgroundColor: AppColors.shiraz.shade100),
                  const SizedBox(
                    width: 4,
                  ),
                  Chip(
                      label: Text(
                        'Costo ${widget.procedure.price} bs.',
                        style: Theme.of(context).textTheme.overline,
                      ),
                      backgroundColor: AppColors.gray.shade200),
                ],
              ),
              //const Icon(MdiIcons.chevronDown),
              //button to display the list
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (iconData != iconData2) {
                      iconData = MdiIcons.chevronUp;
                    } else
                      iconData = MdiIcons.chevronDown;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.white,
                  padding: const EdgeInsets.all(2),
                  shape: const CircleBorder(),
                ),
                child: Icon(
                  iconData,
                  size: 30,
                  color: AppColors.matterhorn,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
