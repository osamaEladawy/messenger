part of 'home_tab_cubit.dart';

sealed class HomeTabState extends Equatable {
  const HomeTabState();

  @override
  List<Object> get props => [];
}

final class HomeTabInitial extends HomeTabState {}

final class ChangeValue extends HomeTabState {
  final int value;

  ChangeValue({required this.value});
}

final class GetDatLoading extends HomeTabState {}

final class GetDatLoaded extends HomeTabState {
  final Map data;

  const GetDatLoaded({required this.data});
}

final class GetDatFailure extends HomeTabState {}

final class ChangeColor extends HomeTabState {}
