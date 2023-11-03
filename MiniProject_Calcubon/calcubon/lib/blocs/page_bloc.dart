import 'package:bloc/bloc.dart';

class PageBloc extends Cubit<int> {
  PageBloc({this.init = 0}) : super(0);

  int init;

  void changeTab(int init) => emit(this.init = init);
}
