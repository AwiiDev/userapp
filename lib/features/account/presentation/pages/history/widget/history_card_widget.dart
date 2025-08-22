import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/common.dart';
import '../../../../../../common/pickup_icon.dart';
import '../../../../../../core/utils/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../application/acc_bloc.dart';
import '../../../../domain/models/history_model.dart';

class HistoryCardWidget extends StatelessWidget {
  final BuildContext cont;
  final HistoryData history;
  const HistoryCardWidget(
      {super.key, required this.cont, required this.history});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return BlocProvider.value(
      value: cont.read<AccBloc>(),
      child: BlocBuilder<AccBloc, AccState>(
        builder: (context, state) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: theme.colorScheme.surface,
            elevation: 2,
            margin: EdgeInsets.only(bottom: size.width * 0.03),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.width * 0.03),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const PickupIcon(),
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: size.width * 0.02),
                              child: MyText(
                                overflow: TextOverflow.ellipsis,
                                text: history.pickAddress,
                                textStyle: theme.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          MyText(
                            text: history.cvTripStartTime,
                            textStyle: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.width * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const DropIcon(),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: size.width * 0.02),
                              child: MyText(
                                overflow: TextOverflow.ellipsis,
                                text: (history.requestStops != null &&
                                    history.requestStops!.isNotEmpty)
                                    ? history.requestStops!.last['address']
                                    : history.dropAddress,
                                textStyle: theme.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          MyText(
                            text: history.cvCompletedAt,
                            textStyle: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(size.width * 0.04),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (history.isOutStation != 1)
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: history.laterRide == true
                                ? history.tripStartTimeWithDate
                                : history.isCompleted == 1
                                ? history.convertedCompletedAt
                                : history.isCancelled == 1
                                ? history.convertedCancelledAt
                                : history.convertedCreatedAt,
                            textStyle: theme.textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: size.width * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.shadow
                                          .withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: history.vehicleTypeImage,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                          color: theme.colorScheme.primary,
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          AppImages.noImage,
                                          fit: BoxFit.cover,
                                        ),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.03),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: history.vehicleTypeName,
                                    textStyle: theme.textTheme.labelLarge!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  if (history.isOutStation == 1 &&
                                      history.isCancelled != 1 &&
                                      history.isCompleted != 1)
                                    MyText(
                                      text: (history.driverDetail != null)
                                          ? AppLocalizations.of(context)!
                                          .assinged
                                          : AppLocalizations.of(context)!
                                          .unAssinged,
                                      textStyle: theme.textTheme.labelMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: (history.driverDetail != null)
                                            ? theme.colorScheme.primary
                                            : theme.colorScheme.error,
                                      ),
                                    ),
                                  MyText(
                                    text: history.carColor,
                                    textStyle: theme.textTheme.labelMedium!
                                        .copyWith(
                                      color:
                                      theme.colorScheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              MyText(
                                text: (history.isOutStation == 1 &&
                                    history.isRoundTrip != '')
                                    ? AppLocalizations.of(context)!
                                    .roundTrip
                                    : AppLocalizations.of(context)!
                                    .oneWayTrip,
                                textStyle: theme.textTheme.bodyLarge!.copyWith(
                                  color: theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (history.isOutStation == 1 &&
                                  history.isRoundTrip != '')
                                Icon(
                                  Icons.import_export,
                                  color: theme.colorScheme.secondary,
                                  size: 20,
                                ),
                            ],
                          ),
                          SizedBox(height: size.width * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.shadow
                                          .withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: history.vehicleTypeImage,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                          color: theme.colorScheme.primary,
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          AppImages.noImage,
                                          fit: BoxFit.cover,
                                        ),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.03),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: history.vehicleTypeName,
                                    textStyle: theme.textTheme.labelLarge!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  MyText(
                                    text: history.carColor,
                                    textStyle: theme.textTheme.labelMedium!
                                        .copyWith(
                                      color:
                                      theme.colorScheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MyText(
                            text: history.isCompleted == 1
                                ? AppLocalizations.of(context)!.completed
                                : history.isCancelled == 1
                                ? AppLocalizations.of(context)!.cancelled
                                : history.isLater == true
                                ? (history.isRental == false)
                                ? AppLocalizations.of(context)!
                                .upcoming
                                : '${AppLocalizations.of(context)!.rental} ${history.rentalPackageName.toString()}'
                                : '',
                            textStyle: theme.textTheme.labelLarge!.copyWith(
                              color: history.isCompleted == 1
                                  ? theme.colorScheme.primary
                                  : history.isCancelled == 1
                                  ? theme.colorScheme.error
                                  : theme.colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: size.width * 0.03),
                          (history.isOutStation != 1)
                              ? MyText(
                            text: (history.isBidRide == 1)
                                ? '${history.requestedCurrencySymbol} ${history.acceptedRideFare}'
                                : (history.isCompleted == 1)
                                ? '${history.requestBill.data.requestedCurrencySymbol} ${history.requestBill.data.totalAmount}'
                                : '${history.requestedCurrencySymbol} ${history.requestEtaAmount}',
                            textStyle: theme.textTheme.bodyLarge!.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MyText(
                                text: (history.laterRide == true &&
                                    history.isOutStation == 1)
                                    ? history.tripStartTime
                                    : (history.laterRide == true &&
                                    history.isOutStation != 1)
                                    ? history.tripStartTimeWithDate
                                    : history.isCompleted == 1
                                    ? history.convertedCompletedAt
                                    : history.isCancelled == 1
                                    ? history.convertedCancelledAt
                                    : history.convertedCreatedAt,
                                textStyle: theme.textTheme.labelMedium!
                                    .copyWith(
                                  color:
                                  theme.colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: size.width * 0.03),
                              MyText(
                                text: history.returnTime,
                                textStyle: theme.textTheme.labelMedium!
                                    .copyWith(
                                  color:
                                  theme.colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: size.width * 0.03),
                              Row(
                                children: [
                                  MyText(
                                    text: (history.paymentOpt == '1')
                                        ? AppLocalizations.of(context)!.cash
                                        : (history.paymentOpt == '2')
                                        ? AppLocalizations.of(context)!
                                        .wallet
                                        : (history.paymentOpt == '0')
                                        ? AppLocalizations.of(
                                        context)!
                                        .card
                                        : '',
                                    textStyle: theme.textTheme.bodyMedium!
                                        .copyWith(
                                      color: theme
                                          .colorScheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  MyText(
                                    text: (history.isBidRide == 1)
                                        ? '${history.requestedCurrencySymbol} ${history.acceptedRideFare}'
                                        : (history.isCompleted == 1)
                                        ? '${history.requestBill.data.requestedCurrencySymbol} ${history.requestBill.data.totalAmount}'
                                        : '${history.requestedCurrencySymbol} ${history.requestEtaAmount}',
                                    textStyle: theme.textTheme.bodyLarge!
                                        .copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}