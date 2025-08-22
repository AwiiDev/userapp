import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_tagxi/common/app_constants.dart';

import '../../../../common/common.dart';
import '../../../../core/utils/custom_loader.dart';
import '../../../../core/utils/custom_text.dart';
import '../../../../core/utils/custom_textfield.dart';
import '../../../../l10n/app_localizations.dart';
import '../../application/driver_profile_bloc.dart';

class GetVehicleInfo extends StatelessWidget {
  final BuildContext cont;
  const GetVehicleInfo({super.key, required this.cont});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider.value(
      value: cont.read<DriverProfileBloc>(),
      child: BlocBuilder<DriverProfileBloc, DriverProfileState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.check_mark,
                      size: size.width * 0.07,
                      color: (context
                          .read<DriverProfileBloc>()
                          .choosenServiceLocation !=
                          null)
                          ? AppColors.black
                          : AppColors.black.withAlpha((0.5 * 255).toInt()),
                    ),
                    SizedBox(width: size.width * 0.025),
                    Expanded(
                        child: MyText(
                          text: AppLocalizations.of(context)!.selectVehicleType,
                          textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: (context
                                .read<DriverProfileBloc>()
                                .choosenServiceLocation !=
                                null)
                                ? AppColors.blackText
                                : AppColors.black
                                .withAlpha((0.5 * 255).toInt()),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: size.width * 0.05),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: size.width * 0.025),
                    Column(
                      children: [
                        for (var i = 0; i < 15; i++)
                          Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            height: 3,
                            width: 1,
                            color: (context
                                .read<DriverProfileBloc>()
                                .choosenVehicleType !=
                                null)
                                ? AppColors.darkGrey
                                : AppColors.black
                                .withAlpha((0.5 * 255).toInt()),
                          )
                      ],
                    ),
                    SizedBox(width: size.width * 0.07),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (context
                              .read<DriverProfileBloc>()
                              .choosenServiceLocation !=
                              null) {
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withAlpha((0.8 * 255).toInt()),
                                    width: size.width,
                                    padding: EdgeInsets.all(size.width * 0.05),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.8,
                                          child: MyText(
                                            text: AppLocalizations.of(context)!
                                                .chooseVehicleType,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                fontSize: 15,
                                                color: (context
                                                    .read<
                                                    DriverProfileBloc>()
                                                    .registerFor !=
                                                    null)
                                                    ? Theme.of(context)
                                                    .primaryColorDark
                                                    : AppColors.black
                                                    .withAlpha(
                                                    (0.5 * 255)
                                                        .toInt()),
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  for (var i = 0;
                                                  i <
                                                      context
                                                          .read<
                                                          DriverProfileBloc>()
                                                          .vehicleType
                                                          .length;
                                                  i++)
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: size.width * 0.05),
                                                      child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                              DriverProfileBloc>()
                                                              .add(UpdateVehicleTypeEvent(
                                                              id: context
                                                                  .read<
                                                                  DriverProfileBloc>()
                                                                  .vehicleType[
                                                              i]
                                                                  .id));
                                                          Navigator.pop(context);
                                                        },
                                                        child: SizedBox(
                                                          width: size.width * 0.8,
                                                          child: Row(
                                                            children: [
                                                              // Ajout de l'icône du type de véhicule
                                                              CachedNetworkImage(
                                                                imageUrl: context
                                                                    .read<
                                                                    DriverProfileBloc>()
                                                                    .vehicleType[i]
                                                                    .icon,
                                                                height: 50,
                                                                width: 50,
                                                                fit: BoxFit.contain,
                                                                placeholder: (context,
                                                                    url) =>
                                                                const SizedBox(
                                                                  height: 50,
                                                                  width: 50,
                                                                  child: Center(
                                                                      child:
                                                                      Loader()),
                                                                ),
                                                                errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(
                                                                    Icons
                                                                        .directions_car,
                                                                    size: 20),
                                                              ),
                                                              const SizedBox(
                                                                  width: 8),
                                                              Expanded(
                                                                child: MyText(
                                                                  text: context
                                                                      .read<
                                                                      DriverProfileBloc>()
                                                                      .vehicleType[i]
                                                                      .name,
                                                                  textStyle: Theme.of(
                                                                      context)
                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .copyWith(
                                                                    fontSize:
                                                                    15,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  );
                                });
                          }
                        },
                        child: Container(
                          height: size.width * 0.10,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: (context
                                      .read<DriverProfileBloc>()
                                      .choosenServiceLocation !=
                                      null)
                                      ? AppColors.darkGrey
                                      : AppColors.black
                                      .withAlpha((0.5 * 255).toInt())),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.only(
                              left: size.width * 0.05,
                              right: size.width * 0.05),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (context.read<DriverProfileBloc>().choosenVehicleType != null) ...[
                                      // ✅ Image du type de véhicule
                                      CachedNetworkImage(
                                        imageUrl: context
                                            .read<DriverProfileBloc>()
                                            .vehicleType
                                            .firstWhere((e) =>
                                        e.id ==
                                            context
                                                .read<DriverProfileBloc>()
                                                .choosenVehicleType)
                                            .icon,
                                        height: 24,
                                        width: 24,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) =>
                                        const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Center(child: Loader()),
                                        ),
                                        errorWidget: (context, url, error) =>
                                        const Icon(
                                            Icons.directions_car,
                                            size: 20),
                                      ),
                                      const SizedBox(
                                          width: 8), // espace entre image et texte
                                    ],
                                    // ✅ Texte du type de véhicule
                                    MyText(
                                      text: (context
                                          .read<DriverProfileBloc>()
                                          .choosenVehicleType !=
                                          null)
                                          ? context
                                          .read<DriverProfileBloc>()
                                          .vehicleType
                                          .firstWhere((e) =>
                                      e.id ==
                                          context
                                              .read<DriverProfileBloc>()
                                              .choosenVehicleType)
                                          .name
                                          : AppLocalizations.of(context)!
                                          .chooseVehicleType,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                        fontSize: 14,
                                        color: (context
                                            .read<
                                            DriverProfileBloc>()
                                            .choosenVehicleType !=
                                            null)
                                            ? AppColors.blackText
                                            : AppColors.black.withAlpha(
                                            (0.5 * 255).toInt()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: (context
                                    .read<DriverProfileBloc>()
                                    .choosenServiceLocation !=
                                    null)
                                    ? AppColors.black
                                    : AppColors.black
                                    .withAlpha((0.5 * 255).toInt()),
                                size: size.width * 0.07,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.check_mark,
                      size: size.width * 0.07,
                      color: (context
                          .read<DriverProfileBloc>()
                          .choosenVehicleType !=
                          null)
                          ? AppColors.black
                          : AppColors.black.withAlpha((0.5 * 255).toInt()),
                    ),
                    SizedBox(width: size.width * 0.025),
                    Expanded(
                        child: MyText(
                          text: AppLocalizations.of(context)!.provideVehicleMake,
                          textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: (context
                                .read<DriverProfileBloc>()
                                .choosenVehicleType !=
                                null)
                                ? AppColors.blackText
                                : AppColors.black
                                .withAlpha((0.5 * 255).toInt()),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: size.width * 0.05),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: size.width * 0.025),
                    Column(
                      children: [
                        for (var i = 0; i < 15; i++)
                          Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            height: 3,
                            width: 1,
                            color: (context
                                .read<DriverProfileBloc>()
                                .customMake != null)
                                ? AppColors.darkGrey
                                : AppColors.black
                                .withAlpha((0.5 * 255).toInt()),
                          )
                      ],
                    ),
                    SizedBox(width: size.width * 0.07),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (context
                              .read<DriverProfileBloc>()
                              .choosenServiceLocation !=
                              null) {
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withAlpha((0.8 * 255).toInt()),
                                    width: size.width,
                                    padding: EdgeInsets.all(size.width * 0.05),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.8,
                                          child: MyText(
                                            text: AppLocalizations.of(context)!
                                                .vehicleMake,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                fontSize: 15,
                                                color: (context
                                                    .read<
                                                    DriverProfileBloc>()
                                                    .registerFor !=
                                                    null)
                                                    ? Theme.of(context)
                                                    .primaryColorDark
                                                    : AppColors.black
                                                    .withAlpha(
                                                    (0.5 * 255)
                                                        .toInt()),
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  for (var i = 0;
                                                  i <
                                                      context
                                                          .read<
                                                          DriverProfileBloc>()
                                                          .vehicleMakes
                                                          .length;
                                                  i++)
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: size.width * 0.05),
                                                      child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                              DriverProfileBloc>()
                                                              .add(UpdateVehicleMakeEvent(
                                                              id: context
                                                                  .read<
                                                                  DriverProfileBloc>()
                                                                  .vehicleMakes[
                                                              i]['id']));
                                                          context
                                                              .read<
                                                              DriverProfileBloc>()
                                                              .add(GetVehicleModelEvent(
                                                              id: context
                                                                  .read<
                                                                  DriverProfileBloc>()
                                                                  .vehicleMakes[i]
                                                              ['id']
                                                                  .toString()));
                                                          Navigator.pop(context);
                                                        },
                                                        child: SizedBox(
                                                          width: size.width * 0.8,
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: MyText(
                                                                  text: context
                                                                      .read<
                                                                      DriverProfileBloc>()
                                                                      .vehicleMakes[i]
                                                                  ['name'],
                                                                  textStyle: Theme.of(
                                                                      context)
                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .copyWith(
                                                                    fontSize:
                                                                    15,
                                                                  ),
                                                                ),
                                                              ),
                                                              Image.network(
                                                                '${AppConstants.baseUrl}storage/uploads/types/images/${context.read<DriverProfileBloc>().vehicleMakes[i]['logo']}',
                                                                width: 50,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  );
                                });
                          }
                        },
                        child: Container(
                          height: size.width * 0.10,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: (context
                                      .read<DriverProfileBloc>()
                                      .choosenServiceLocation !=
                                      null)
                                      ? AppColors.darkGrey
                                      : AppColors.black
                                      .withAlpha((0.5 * 255).toInt())),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.only(
                              left: size.width * 0.05,
                              right: size.width * 0.05),
                          child: Row(
                            children: [
                              Expanded(
                                child: MyText(
                                  text: (context
                                      .read<DriverProfileBloc>()
                                      .customMake !=
                                      null)
                                      ? context
                                      .read<DriverProfileBloc>()
                                      .vehicleMakes
                                      .firstWhere((e) =>
                                  e['id'] ==
                                      context
                                          .read<DriverProfileBloc>()
                                          .customMake)['name']
                                      : AppLocalizations.of(context)!
                                      .chooseVehicleType,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                    fontSize: 14,
                                    color: (context
                                        .read<DriverProfileBloc>()
                                        .choosenVehicleType !=
                                        null)
                                        ? AppColors.blackText
                                        : AppColors.black
                                        .withAlpha((0.5 * 255).toInt()),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: (context
                                    .read<DriverProfileBloc>()
                                    .choosenServiceLocation !=
                                    null)
                                    ? AppColors.black
                                    : AppColors.black
                                    .withAlpha((0.5 * 255).toInt()),
                                size: size.width * 0.07,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.check_mark,
                      size: size.width * 0.07,
                      color: (context
                          .read<DriverProfileBloc>()
                          .customMake != null)
                          ? AppColors.black
                          : AppColors.black.withAlpha((0.5 * 255).toInt()),
                    ),
                    SizedBox(width: size.width * 0.025),
                    Expanded(
                        child: MyText(
                          text: AppLocalizations.of(context)!.provideVehicleModel,
                          textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: (context
                                .read<DriverProfileBloc>()
                                .customMake != null)
                                ? AppColors.black
                                : AppColors.black
                                .withAlpha((0.5 * 255).toInt()),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: size.width * 0.05),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: size.width * 0.025),
                    Column(
                      children: [
                        for (var i = 0; i < 15; i++)
                          Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            height: 3,
                            width: 1,
                            color: (context
                                .read<DriverProfileBloc>()
                                .customModel != null)
                                ? AppColors.darkGrey
                                : AppColors.black
                                .withAlpha((0.5 * 255).toInt()),
                          )
                      ],
                    ),
                    SizedBox(width: size.width * 0.07),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (context
                              .read<DriverProfileBloc>()
                              .customMake !=
                              null) {
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withAlpha((0.8 * 255).toInt()),
                                    width: size.width,
                                    padding: EdgeInsets.all(size.width * 0.05),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.8,
                                          child: MyText(
                                            text: AppLocalizations.of(context)!
                                                .vehicleModel,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                fontSize: 15,
                                                color: (context
                                                    .read<
                                                    DriverProfileBloc>()
                                                    .registerFor !=
                                                    null)
                                                    ? Theme.of(context)
                                                    .primaryColorDark
                                                    : AppColors.black
                                                    .withAlpha(
                                                    (0.5 * 255)
                                                        .toInt()),
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  for (var i = 0;
                                                  i <
                                                      context
                                                          .read<
                                                          DriverProfileBloc>()
                                                          .vehicleModels
                                                          .length;
                                                  i++)
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: size.width * 0.05),
                                                      child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                              DriverProfileBloc>()
                                                              .add(UpdateVehicleModelEvent(
                                                              id: context
                                                                  .read<
                                                                  DriverProfileBloc>()
                                                                  .vehicleModels[
                                                              i]['id']));
                                                          Navigator.pop(context);
                                                        },
                                                        child: SizedBox(
                                                          width: size.width * 0.8,
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: MyText(
                                                                  text: context
                                                                      .read<
                                                                      DriverProfileBloc>()
                                                                      .vehicleModels[i]
                                                                  ['name'],
                                                                  textStyle: Theme.of(
                                                                      context)
                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .copyWith(
                                                                    fontSize:
                                                                    15,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  );
                                });
                          }
                        },
                        child: Container(
                          height: size.width * 0.10,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: (context
                                      .read<DriverProfileBloc>()
                                      .customMake !=
                                      null)
                                      ? AppColors.darkGrey
                                      : AppColors.black
                                      .withAlpha((0.5 * 255).toInt())),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.only(
                              left: size.width * 0.05,
                              right: size.width * 0.05),
                          child: Row(
                            children: [
                              Expanded(
                                child: MyText(
                                  text: (context
                                      .read<DriverProfileBloc>()
                                      .customModel !=
                                      null)
                                      ? context
                                      .read<DriverProfileBloc>()
                                      .vehicleModels
                                      .firstWhere((e) =>
                                  e['id'] ==
                                      context
                                          .read<DriverProfileBloc>()
                                          .customModel)['name']
                                      : AppLocalizations.of(context)!
                                      .vehicleModel,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                    fontSize: 14,
                                    color: (context
                                        .read<DriverProfileBloc>()
                                        .customMake !=
                                        null)
                                        ? AppColors.blackText
                                        : AppColors.black
                                        .withAlpha((0.5 * 255).toInt()),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: (context
                                    .read<DriverProfileBloc>()
                                    .customMake !=
                                    null)
                                    ? AppColors.black
                                    : AppColors.black
                                    .withAlpha((0.5 * 255).toInt()),
                                size: size.width * 0.07,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.check_mark,
                      size: size.width * 0.07,
                      color: (context
                          .read<DriverProfileBloc>()
                          .customModel != null)
                          ? AppColors.black
                          : AppColors.black.withAlpha((0.5 * 255).toInt()),
                    ),
                    SizedBox(width: size.width * 0.025),
                    Expanded(
                        child: MyText(
                          text: AppLocalizations.of(context)!.provideModelYear,
                          textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: (context
                                .read<DriverProfileBloc>()
                                .customModel != null)
                                ? AppColors.blackText
                                : AppColors.black
                                .withAlpha((0.5 * 255).toInt()),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: size.width * 0.05),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    Column(
                      children: [
                        for (var i = 0; i < 15; i++)
                          Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            height: 3,
                            width: 1,
                            color: (context
                                .read<DriverProfileBloc>()
                                .vehicleYear
                                .text
                                .isNotEmpty)
                                ? AppColors.darkGrey
                                : AppColors.black
                                .withAlpha((0.5 * 255).toInt()),
                          )
                      ],
                    ),
                    SizedBox(width: size.width * 0.07),
                    Expanded(
                      child: CustomTextField(
                        maxLength: 4,
                        onChange: (v) {
                          context
                              .read<DriverProfileBloc>()
                              .add(DriverUpdateEvent());
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        enabled: context
                            .read<DriverProfileBloc>()
                            .customModel != null,
                        hintText: AppLocalizations.of(context)!.enterModelYear,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                          color: AppColors.blackText,
                        ),
                        controller:
                        context.read<DriverProfileBloc>().vehicleYear,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.darkGrey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.darkGrey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.black
                                  .withAlpha((0.5 * 255).toInt()),
                              width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        validator: (string) {
                          if (string != null && string.length <= 3) {
                            return AppLocalizations.of(context)!.validDateValue;
                          } else if (string != null &&
                              string.length == 4 &&
                              int.parse(string) > DateTime.now().year) {
                            return AppLocalizations.of(context)!.validDateValue;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.check_mark,
                      size: size.width * 0.07,
                      color: (context
                          .read<DriverProfileBloc>()
                          .vehicleYear
                          .text
                          .isNotEmpty)
                          ? AppColors.black
                          : AppColors.black.withAlpha((0.5 * 255).toInt()),
                    ),
                    SizedBox(width: size.width * 0.025),
                    Expanded(
                        child: MyText(
                          text: AppLocalizations.of(context)!.provideVehicleNumber,
                          textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: (context
                                .read<DriverProfileBloc>()
                                .vehicleYear
                                .text
                                .isNotEmpty)
                                ? AppColors.blackText
                                : AppColors.black
                                .withAlpha((0.5 * 255).toInt()),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: size.width * 0.05),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: size.width * 0.025),
                    Column(
                      children: [
                        for (var i = 0; i < 15; i++)
                          Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            height: 3,
                            width: 1,
                            color: (context
                                .read<DriverProfileBloc>()
                                .vehicleNumber
                                .text
                                .isNotEmpty)
                                ? AppColors.darkGrey
                                : AppColors.black
                                .withAlpha((0.5 * 255).toInt()),
                          )
                      ],
                    ),
                    SizedBox(width: size.width * 0.07),
                    Expanded(
                      child: CustomTextField(
                        enabled: context
                            .read<DriverProfileBloc>()
                            .vehicleYear
                            .text
                            .isNotEmpty,
                        onChange: (v) {
                          context
                              .read<DriverProfileBloc>()
                              .add(DriverUpdateEvent());
                        },
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                          color: AppColors.blackText,
                        ),
                        hintText:
                        AppLocalizations.of(context)!.enterVehicleNumber,
                        controller:
                        context.read<DriverProfileBloc>().vehicleNumber,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.darkGrey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.darkGrey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.black
                                  .withAlpha((0.5 * 255).toInt()),
                              width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.check_mark,
                      size: size.width * 0.07,
                      color: (context
                          .read<DriverProfileBloc>()
                          .vehicleNumber
                          .text
                          .isNotEmpty)
                          ? AppColors.black
                          : AppColors.black.withAlpha((0.5 * 255).toInt()),
                    ),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    Expanded(
                        child: MyText(
                          text: AppLocalizations.of(context)!.provideVehicleColor,
                          textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: (context
                                .read<DriverProfileBloc>()
                                .vehicleNumber
                                .text
                                .isNotEmpty)
                                ? AppColors.blackText
                                : AppColors.black
                                .withAlpha((0.5 * 255).toInt()),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: size.width * 0.05),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: size.width * 0.025),
                    Column(
                      children: [
                        for (var i = 0; i < 15; i++)
                          Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            height: 3,
                            width: 1,
                            color: Colors.transparent,
                          )
                      ],
                    ),
                    SizedBox(width: size.width * 0.07),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (context
                              .read<DriverProfileBloc>()
                              .vehicleNumber.text.isNotEmpty) {
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withAlpha((0.8 * 255).toInt()),
                                    width: size.width,
                                    padding: EdgeInsets.all(size.width * 0.05),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.8,
                                          child: MyText(
                                            text: AppLocalizations.of(context)!
                                                .provideVehicleColor,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                fontSize: 15,
                                                color: (context
                                                    .read<
                                                    DriverProfileBloc>()
                                                    .registerFor !=
                                                    null)
                                                    ? Theme.of(context)
                                                    .primaryColorDark
                                                    : AppColors.black
                                                    .withAlpha(
                                                    (0.5 * 255)
                                                        .toInt()),
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  for (var i = 0;
                                                  i <
                                                      context
                                                          .read<
                                                          DriverProfileBloc>()
                                                          .vehicleColors
                                                          .length;
                                                  i++)
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: size.width * 0.05),
                                                      child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                              DriverProfileBloc>()
                                                              .add(UpdateVehicleColorEvent(
                                                              id: context
                                                                  .read<
                                                                  DriverProfileBloc>()
                                                                  .vehicleColors[
                                                              i]['id']));
                                                          Navigator.pop(context);
                                                        },
                                                        child: SizedBox(
                                                          width: size.width * 0.8,
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: MyText(
                                                                  text: context
                                                                      .read<
                                                                      DriverProfileBloc>()
                                                                      .vehicleColors[i]
                                                                  ['name'],
                                                                  textStyle: Theme.of(
                                                                      context)
                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .copyWith(
                                                                    fontSize:
                                                                    15,
                                                                  ),
                                                                ),
                                                              ),
                                                              Image.network(
                                                                '${AppConstants.baseUrl}storage/uploads/types/images/${context.read<DriverProfileBloc>().vehicleColors[i]['logo']}',
                                                                width: 50,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  );
                                });
                          }
                        },
                        child: Container(
                          height: size.width * 0.10,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: (context
                                      .read<DriverProfileBloc>()
                                      .vehicleNumber.text.isNotEmpty)
                                      ? AppColors.darkGrey
                                      : AppColors.black
                                      .withAlpha((0.5 * 255).toInt())),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.only(
                              left: size.width * 0.05,
                              right: size.width * 0.05),
                          child: Row(
                            children: [
                              Expanded(
                                child: MyText(
                                  text: (context
                                      .read<DriverProfileBloc>()
                                      .vehicleColor !=
                                      null)
                                      ? context
                                      .read<DriverProfileBloc>()
                                      .vehicleColors
                                      .firstWhere((e) =>
                                  e['id'] ==
                                      context
                                          .read<DriverProfileBloc>()
                                          .vehicleColor)['name']
                                      : AppLocalizations.of(context)!
                                      .provideVehicleColor,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                    fontSize: 14,
                                    color: (context
                                        .read<DriverProfileBloc>()
                                        .vehicleNumber
                                        .text
                                        .isNotEmpty)
                                        ? AppColors.blackText
                                        : AppColors.black
                                        .withAlpha((0.5 * 255).toInt()),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: (context
                                    .read<DriverProfileBloc>()
                                    .customMake !=
                                    null)
                                    ? AppColors.black
                                    : AppColors.black
                                    .withAlpha((0.5 * 255).toInt()),
                                size: size.width * 0.07,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}