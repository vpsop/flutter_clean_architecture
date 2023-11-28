import 'package:flutter_clean_architecture/data/datasources/advice_remote_datasource.dart';
import 'package:flutter_clean_architecture/data/models/advice_model.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart';

// import 'advice_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('AdviceRemoteDatasource', () {
    group('should return AdviceModel', () {
      test("when client response was 200 and has valid data", () async {
        const responseBody = '{"advice": "test advice", "advice_id": 1}';
        final mockClient = MockClient((req) {
          return Future.value(Response(responseBody, 200));
        });

        final adviceRemoteDatasourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);

        final result =
            await adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi();

        expect(result, AdviceModel(advice: "test advice", id: 1));
      });
    });
  });
}
