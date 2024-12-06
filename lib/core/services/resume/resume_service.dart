import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/resume/resume_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/resume_per_cycle_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/resume_summary_response.dart';

abstract class ResumeService {
  Future<BaseResponse<ResumeSummaryResponse>> summary({
    required String fishPondID,
  });
  Future<BaseResponse<ResumePerCycleResponse>> resumePerCycle({
    required String fishPondID,
  });
}

class ResumeServiceImpl implements ResumeService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final ResumeEndpoint endpoint;

  ResumeServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory ResumeServiceImpl.create() {
    return ResumeServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: ResumeEndpoint(),
    );
  }

  @override
  Future<BaseResponse<ResumeSummaryResponse>> summary({
    required String fishPondID,
  }) async {
    final url = endpoint.getSummary(fishPondID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final data = ResumeSummaryResponse.fromMap(meta.result!);
    return BaseResponse(data: data, meta: meta);
  }

  @override
  Future<BaseResponse<ResumePerCycleResponse>> resumePerCycle({
    required String fishPondID,
  }) async {
    final url = endpoint.getResumePerCycle(fishPondID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final data = ResumePerCycleResponse.fromMap(meta.result!);
    return BaseResponse(data: data, meta: meta);
  }
}
