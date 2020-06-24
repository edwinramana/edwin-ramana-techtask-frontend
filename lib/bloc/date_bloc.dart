
import 'package:rxdart/rxdart.dart';

class DateBloc {
  final _dateFetcher = PublishSubject<DateTime>();

  Stream<DateTime> get date => _dateFetcher.stream;

  setDate(DateTime dateTime) async {

    _dateFetcher.sink.add(dateTime);
  }

  disposeNetwork() {
    _dateFetcher.close();
  }
}