part of arcgis_maps_flutter;

@immutable
class GeocodeParameters {
  const GeocodeParameters({
    this.resultAttributeNames = const [],
    this.categories = const [],
    this.countryCode = '',
    this.forStorage = false,
    this.maxResults = 10,
    this.minScore = 75,
    this.outputLanguageCode = '',
    this.outputSpatialReference,
    this.preferredSearchLocation,
    this.searchArea,
  });

  /// List of attributes to be returned for each geocoded result.
  /// The attributes available are specified by [LocatorInfo.resultAttributes]
  /// and [LocatorInfo.intersectionResultAttributes].
  /// Use "*" to return all attributes.
  final List<String> resultAttributeNames;

  /// Categories by which to filter geocoded results.
  /// Categories represent address and place types,
  /// for example "city", "school", "Ski Resort".
  /// By default no category filtering is applied.
  /// https://developers.arcgis.com/rest/geocode/api-reference/geocoding-category-filtering.htm
  final List<String> categories;

  /// Country by which to filter results. This can speed up the geocoding operation.
  /// Acceptable values include the full country name in English or the official
  /// language of the country, the ISO 3166-1 2-digit country code, or the
  /// ISO 3166-1 3-digit country code.
  /// https://developers.arcgis.com/rest/geocode/api-reference/geocode-coverage.htm
  final String countryCode;

  /// Specifies whether the results of the operation should be persisted.
  /// The default value is false, which indicates the results of the operation
  /// can't be stored, but they can be temporarily displayed on a map for instance.
  /// If you store the results in a database, for example, you need to set this
  /// parameter to true.
  /// Applications are contractually prohibited from storing the results of
  /// geocoding transactions unless they perform the operation as an
  /// authenticated user.
  /// ArcGIS Online service credits are deducted from the organization account
  /// for each geocode transaction that uses this capability.
  final bool forStorage;

  /// The maximum number of results desired.
  /// Only applies when using an ArcGIS Geocode service
  /// (i.e not geocoding locally on the device using a locator dataset).
  /// Please consult the service properties for information on the largest
  /// acceptable value for this parameter.
  final int maxResults;

  /// Minimum match score of the results. Results which have a match score lower
  /// than this value will not be returned.
  /// Only applies when geocoding locally on the device using a locator dataset
  /// (i.e not using an ArcGIS Geocode service).
  final int minScore;

  /// The language in which results should be returned.
  /// Based on the 2-digit ISO 639-1 language code.
  final String outputLanguageCode;

  /// The spatial reference in which the results are returned.
  final SpatialReference? outputSpatialReference;

  /// The location by which to prioritize/order geocoded results.
  /// Results that fall within a 50 KM buffer of this location are boosted
  /// in rank so that they show up higher in the list of candidates, but results
  /// further away are still included. To exclude results based on a region,
  /// use [searchArea] instead. The preferred search location is only intended
  /// to influence the sort order of results so that the most locationally-relevant
  /// candidates are returned first.
  final AGSPoint? preferredSearchLocation;

  /// The search area used to spatially filter the geocoded results.
  /// Only results that lie within this area are included.
  final Geometry? searchArea;

  Object toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (resultAttributeNames.isNotEmpty) {
      json['resultAttributeNames'] = resultAttributeNames;
    }
    if (categories.isNotEmpty) {
      json['categories'] = categories;
    }
    if (countryCode.isNotEmpty) {
      json['countryCode'] = countryCode;
    }

    json['forStorage'] = forStorage;
    json['maxResults'] = maxResults;
    json['minScore'] = minScore;
    if (outputLanguageCode.isNotEmpty) {
      json['outputLanguageCode'] = outputLanguageCode;
    }
    if (outputSpatialReference != null) {
      json['outputSpatialReference'] = outputSpatialReference!.toJson();
    }
    if (preferredSearchLocation != null) {
      json['preferredSearchLocation'] = preferredSearchLocation!.toJson();
    }
    if (searchArea != null) {
      json['searchArea'] = searchArea!.toJson();
    }

    return json;
  }
}
