// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Add Branch`
  String get addBranch {
    return Intl.message(
      'Add Branch',
      name: 'addBranch',
      desc: '',
      args: [],
    );
  }

  /// `Field cannot be empty`
  String get emptyValidation {
    return Intl.message(
      'Field cannot be empty',
      name: 'emptyValidation',
      desc: '',
      args: [],
    );
  }

  /// `Branch Name`
  String get branchName {
    return Intl.message(
      'Branch Name',
      name: 'branchName',
      desc: '',
      args: [],
    );
  }

  /// `Branch Address`
  String get branchAddress {
    return Intl.message(
      'Branch Address',
      name: 'branchAddress',
      desc: '',
      args: [],
    );
  }

  /// `Select Branch Hub`
  String get selectBranchHub {
    return Intl.message(
      'Select Branch Hub',
      name: 'selectBranchHub',
      desc: '',
      args: [],
    );
  }

  /// `Branch Hub`
  String get branchHub {
    return Intl.message(
      'Branch Hub',
      name: 'branchHub',
      desc: '',
      args: [],
    );
  }

  /// `Select Branch Franchise`
  String get selectBranchFranchise {
    return Intl.message(
      'Select Branch Franchise',
      name: 'selectBranchFranchise',
      desc: '',
      args: [],
    );
  }

  /// `Please select a branch franchise!`
  String get selectBranchFranchiseValidation {
    return Intl.message(
      'Please select a branch franchise!',
      name: 'selectBranchFranchiseValidation',
      desc: '',
      args: [],
    );
  }

  /// `Branch Franchise`
  String get branchFranchise {
    return Intl.message(
      'Branch Franchise',
      name: 'branchFranchise',
      desc: '',
      args: [],
    );
  }

  /// `Latitude`
  String get latitude {
    return Intl.message(
      'Latitude',
      name: 'latitude',
      desc: '',
      args: [],
    );
  }

  /// `Longitude`
  String get longitude {
    return Intl.message(
      'Longitude',
      name: 'longitude',
      desc: '',
      args: [],
    );
  }

  /// `Move Camera`
  String get moveCamera {
    return Intl.message(
      'Move Camera',
      name: 'moveCamera',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get columnName {
    return Intl.message(
      'Name',
      name: 'columnName',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get columnAddress {
    return Intl.message(
      'Address',
      name: 'columnAddress',
      desc: '',
      args: [],
    );
  }

  /// `Hub`
  String get columnHub {
    return Intl.message(
      'Hub',
      name: 'columnHub',
      desc: '',
      args: [],
    );
  }

  /// `Franchise`
  String get columnFranchise {
    return Intl.message(
      'Franchise',
      name: 'columnFranchise',
      desc: '',
      args: [],
    );
  }

  /// `Created At`
  String get columnCreatedAt {
    return Intl.message(
      'Created At',
      name: 'columnCreatedAt',
      desc: '',
      args: [],
    );
  }

  /// `Updated At`
  String get columnUpdatedAt {
    return Intl.message(
      'Updated At',
      name: 'columnUpdatedAt',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get columnActions {
    return Intl.message(
      'Actions',
      name: 'columnActions',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm Delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `No branches yet!`
  String get noBranchesYet {
    return Intl.message(
      'No branches yet!',
      name: 'noBranchesYet',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the branch name`
  String get pleaseEnterBranchName {
    return Intl.message(
      'Please enter the branch name',
      name: 'pleaseEnterBranchName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the branch address`
  String get pleaseEnterBranchAddress {
    return Intl.message(
      'Please enter the branch address',
      name: 'pleaseEnterBranchAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please select the branch hub`
  String get pleaseSelectBranchHub {
    return Intl.message(
      'Please select the branch hub',
      name: 'pleaseSelectBranchHub',
      desc: '',
      args: [],
    );
  }

  /// `Please select a branch franchise`
  String get pleaseSelectBranchFranchise {
    return Intl.message(
      'Please select a branch franchise',
      name: 'pleaseSelectBranchFranchise',
      desc: '',
      args: [],
    );
  }

  /// `Edit Branch`
  String get editBranch {
    return Intl.message(
      'Edit Branch',
      name: 'editBranch',
      desc: '',
      args: [],
    );
  }

  /// `Update Franchise`
  String get updateFranchise {
    return Intl.message(
      'Update Franchise',
      name: 'updateFranchise',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the franchise name!`
  String get pleaseEnterFranchiseName {
    return Intl.message(
      'Please enter the franchise name!',
      name: 'pleaseEnterFranchiseName',
      desc: '',
      args: [],
    );
  }

  /// `Franchise Name`
  String get franchiseName {
    return Intl.message(
      'Franchise Name',
      name: 'franchiseName',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Branches`
  String get branches {
    return Intl.message(
      'Branches',
      name: 'branches',
      desc: '',
      args: [],
    );
  }

  /// `Created At`
  String get createdAt {
    return Intl.message(
      'Created At',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  /// `Updated At`
  String get updatedAt {
    return Intl.message(
      'Updated At',
      name: 'updatedAt',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `N/A`
  String get nA {
    return Intl.message(
      'N/A',
      name: 'nA',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this franchise?`
  String get confirmDeleteFranchise {
    return Intl.message(
      'Are you sure you want to delete this franchise?',
      name: 'confirmDeleteFranchise',
      desc: '',
      args: [],
    );
  }

  /// `Add Franchise`
  String get addFranchise {
    return Intl.message(
      'Add Franchise',
      name: 'addFranchise',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Hubs`
  String get hubs {
    return Intl.message(
      'Hubs',
      name: 'hubs',
      desc: '',
      args: [],
    );
  }

  /// `Managers`
  String get managers {
    return Intl.message(
      'Managers',
      name: 'managers',
      desc: '',
      args: [],
    );
  }

  /// `Franchises`
  String get franchises {
    return Intl.message(
      'Franchises',
      name: 'franchises',
      desc: '',
      args: [],
    );
  }

  /// `Riders`
  String get riders {
    return Intl.message(
      'Riders',
      name: 'riders',
      desc: '',
      args: [],
    );
  }

  /// `Navigation`
  String get navigation {
    return Intl.message(
      'Navigation',
      name: 'navigation',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Add Hub`
  String get addHub {
    return Intl.message(
      'Add Hub',
      name: 'addHub',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the Hub's name!`
  String get pleaseEnterHubName {
    return Intl.message(
      'Please enter the Hub\'s name!',
      name: 'pleaseEnterHubName',
      desc: '',
      args: [],
    );
  }

  /// `Hub Name`
  String get hubName {
    return Intl.message(
      'Hub Name',
      name: 'hubName',
      desc: '',
      args: [],
    );
  }

  /// `Select Hub Manager`
  String get selectHubManager {
    return Intl.message(
      'Select Hub Manager',
      name: 'selectHubManager',
      desc: '',
      args: [],
    );
  }

  /// `Please select a Hub Manager!`
  String get selectHubManagerValidation {
    return Intl.message(
      'Please select a Hub Manager!',
      name: 'selectHubManagerValidation',
      desc: '',
      args: [],
    );
  }

  /// `Hub Manager`
  String get hubManager {
    return Intl.message(
      'Hub Manager',
      name: 'hubManager',
      desc: '',
      args: [],
    );
  }

  /// `Please select the hub location`
  String get selectHubLocation {
    return Intl.message(
      'Please select the hub location',
      name: 'selectHubLocation',
      desc: '',
      args: [],
    );
  }

  /// `Edit Hub`
  String get editHub {
    return Intl.message(
      'Edit Hub',
      name: 'editHub',
      desc: '',
      args: [],
    );
  }

  /// `Manager`
  String get manager {
    return Intl.message(
      'Manager',
      name: 'manager',
      desc: '',
      args: [],
    );
  }

  /// `No Data Found`
  String get noDataFound {
    return Intl.message(
      'No Data Found',
      name: 'noDataFound',
      desc: '',
      args: [],
    );
  }

  /// `Manager Name`
  String get managerName {
    return Intl.message(
      'Manager Name',
      name: 'managerName',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this Hub?`
  String get hubDeleteConfirmation {
    return Intl.message(
      'Are you sure you want to delete this Hub?',
      name: 'hubDeleteConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `No Hubs Yet!`
  String get noHubsYet {
    return Intl.message(
      'No Hubs Yet!',
      name: 'noHubsYet',
      desc: '',
      args: [],
    );
  }

  /// `Tayaar App`
  String get appName {
    return Intl.message(
      'Tayaar App',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Manager Password`
  String get managerPassword {
    return Intl.message(
      'Manager Password',
      name: 'managerPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the manager's name!`
  String get pleaseEnterManagerName {
    return Intl.message(
      'Please enter the manager\'s name!',
      name: 'pleaseEnterManagerName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the manager's password!`
  String get pleaseEnterManagerPassword {
    return Intl.message(
      'Please enter the manager\'s password!',
      name: 'pleaseEnterManagerPassword',
      desc: '',
      args: [],
    );
  }

  /// `Add Manager`
  String get addManager {
    return Intl.message(
      'Add Manager',
      name: 'addManager',
      desc: '',
      args: [],
    );
  }

  /// `Edit Manager`
  String get editManager {
    return Intl.message(
      'Edit Manager',
      name: 'editManager',
      desc: '',
      args: [],
    );
  }

  /// `No Managers Yet!`
  String get noManagersYet {
    return Intl.message(
      'No Managers Yet!',
      name: 'noManagersYet',
      desc: '',
      args: [],
    );
  }

  /// `Add Rider`
  String get addRider {
    return Intl.message(
      'Add Rider',
      name: 'addRider',
      desc: '',
      args: [],
    );
  }

  /// `Rider Name`
  String get riderName {
    return Intl.message(
      'Rider Name',
      name: 'riderName',
      desc: '',
      args: [],
    );
  }

  /// `Rider National ID`
  String get riderNationalId {
    return Intl.message(
      'Rider National ID',
      name: 'riderNationalId',
      desc: '',
      args: [],
    );
  }

  /// `Rider Phone Number`
  String get riderPhoneNumber {
    return Intl.message(
      'Rider Phone Number',
      name: 'riderPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Rider Password`
  String get riderPassword {
    return Intl.message(
      'Rider Password',
      name: 'riderPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the Rider name!`
  String get pleaseEnterRiderName {
    return Intl.message(
      'Please enter the Rider name!',
      name: 'pleaseEnterRiderName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the Rider National ID!`
  String get pleaseEnterRiderNationalId {
    return Intl.message(
      'Please enter the Rider National ID!',
      name: 'pleaseEnterRiderNationalId',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the Rider Phone Number!`
  String get pleaseEnterRiderPhoneNumber {
    return Intl.message(
      'Please enter the Rider Phone Number!',
      name: 'pleaseEnterRiderPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the Rider Password!`
  String get pleaseEnterRiderPassword {
    return Intl.message(
      'Please enter the Rider Password!',
      name: 'pleaseEnterRiderPassword',
      desc: '',
      args: [],
    );
  }

  /// `Select Hub`
  String get selectHub {
    return Intl.message(
      'Select Hub',
      name: 'selectHub',
      desc: '',
      args: [],
    );
  }

  /// `Please select a hub`
  String get pleaseSelectHub {
    return Intl.message(
      'Please select a hub',
      name: 'pleaseSelectHub',
      desc: '',
      args: [],
    );
  }

  /// `Change Rider Hub`
  String get changeRiderHub {
    return Intl.message(
      'Change Rider Hub',
      name: 'changeRiderHub',
      desc: '',
      args: [],
    );
  }

  /// `Select Rider Hub`
  String get selectRiderHub {
    return Intl.message(
      'Select Rider Hub',
      name: 'selectRiderHub',
      desc: '',
      args: [],
    );
  }

  /// `Please select a Rider hub!`
  String get selectRiderHubValidation {
    return Intl.message(
      'Please select a Rider hub!',
      name: 'selectRiderHubValidation',
      desc: '',
      args: [],
    );
  }

  /// `Rider Hub`
  String get riderHub {
    return Intl.message(
      'Rider Hub',
      name: 'riderHub',
      desc: '',
      args: [],
    );
  }

  /// `Change Rider Hub`
  String get changeRiderHubButton {
    return Intl.message(
      'Change Rider Hub',
      name: 'changeRiderHubButton',
      desc: '',
      args: [],
    );
  }

  /// `Change Shift Times`
  String get changeShiftTimes {
    return Intl.message(
      'Change Shift Times',
      name: 'changeShiftTimes',
      desc: '',
      args: [],
    );
  }

  /// `Select Start Time`
  String get selectStartTime {
    return Intl.message(
      'Select Start Time',
      name: 'selectStartTime',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get startTime {
    return Intl.message(
      'Start Time',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `Shift Duration:`
  String get shiftDuration {
    return Intl.message(
      'Shift Duration:',
      name: 'shiftDuration',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get endTime {
    return Intl.message(
      'End Time',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid hours and minutes.`
  String get invalidTimeInput {
    return Intl.message(
      'Please enter valid hours and minutes.',
      name: 'invalidTimeInput',
      desc: '',
      args: [],
    );
  }

  /// `Please select a start time.`
  String get selectStartTimeError {
    return Intl.message(
      'Please select a start time.',
      name: 'selectStartTimeError',
      desc: '',
      args: [],
    );
  }

  /// `Delete Rider`
  String get deleteRider {
    return Intl.message(
      'Delete Rider',
      name: 'deleteRider',
      desc: '',
      args: [],
    );
  }

  /// `Edit Rider`
  String get editRider {
    return Intl.message(
      'Edit Rider',
      name: 'editRider',
      desc: '',
      args: [],
    );
  }

  /// `Change Hub`
  String get changeHub {
    return Intl.message(
      'Change Hub',
      name: 'changeHub',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this Rider?`
  String get deleteRiderConfirmation {
    return Intl.message(
      'Are you sure you want to delete this Rider?',
      name: 'deleteRiderConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `No Riders Yet!`
  String get noRidersYet {
    return Intl.message(
      'No Riders Yet!',
      name: 'noRidersYet',
      desc: '',
      args: [],
    );
  }

  /// `User ID:`
  String get userId {
    return Intl.message(
      'User ID:',
      name: 'userId',
      desc: '',
      args: [],
    );
  }

  /// `National ID:`
  String get nationalId {
    return Intl.message(
      'National ID:',
      name: 'nationalId',
      desc: '',
      args: [],
    );
  }

  /// `Phone:`
  String get phone {
    return Intl.message(
      'Phone:',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Queue No:`
  String get queueNo {
    return Intl.message(
      'Queue No:',
      name: 'queueNo',
      desc: '',
      args: [],
    );
  }

  /// `Current Order ID:`
  String get currentOrderId {
    return Intl.message(
      'Current Order ID:',
      name: 'currentOrderId',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
