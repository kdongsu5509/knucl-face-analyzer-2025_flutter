
class AnalyzeResultDTO {
  final String result;
  final String uuid;

  AnalyzeResultDTO({required this.result, required this.uuid});

  factory AnalyzeResultDTO.fromJson(Map<String, dynamic> json) {
    return AnalyzeResultDTO(
      result: json['result'],
      uuid: json['uuid'],
    );
  }
}
