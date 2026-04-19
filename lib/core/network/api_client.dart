class ApiClient {
  const ApiClient();

  Future<Map<String, dynamic>> get(String endpoint) async {
    throw UnimplementedError('Configure remote API client for $endpoint');
  }
}
