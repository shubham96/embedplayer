class RoutingData{
  late final String route;
  late final Map<String, String> _queryParameters;


  RoutingData({
    required this.route, required Map<String, String> queryParameters
}): _queryParameters = queryParameters;

  operator [](String key) => _queryParameters[key];

}