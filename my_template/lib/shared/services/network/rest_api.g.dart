// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$restApiHash() => r'ae0abcc4e999f521116788921a7f3ad41623b8e7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [restApi].
@ProviderFor(restApi)
const restApiProvider = RestApiFamily();

/// See also [restApi].
class RestApiFamily extends Family<RestApi> {
  /// See also [restApi].
  const RestApiFamily();

  /// See also [restApi].
  RestApiProvider call(
    String baseUrl,
  ) {
    return RestApiProvider(
      baseUrl,
    );
  }

  @override
  RestApiProvider getProviderOverride(
    covariant RestApiProvider provider,
  ) {
    return call(
      provider.baseUrl,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'restApiProvider';
}

/// See also [restApi].
class RestApiProvider extends AutoDisposeProvider<RestApi> {
  /// See also [restApi].
  RestApiProvider(
    String baseUrl,
  ) : this._internal(
          (ref) => restApi(
            ref as RestApiRef,
            baseUrl,
          ),
          from: restApiProvider,
          name: r'restApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$restApiHash,
          dependencies: RestApiFamily._dependencies,
          allTransitiveDependencies: RestApiFamily._allTransitiveDependencies,
          baseUrl: baseUrl,
        );

  RestApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.baseUrl,
  }) : super.internal();

  final String baseUrl;

  @override
  Override overrideWith(
    RestApi Function(RestApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RestApiProvider._internal(
        (ref) => create(ref as RestApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        baseUrl: baseUrl,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<RestApi> createElement() {
    return _RestApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RestApiProvider && other.baseUrl == baseUrl;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, baseUrl.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RestApiRef on AutoDisposeProviderRef<RestApi> {
  /// The parameter `baseUrl` of this provider.
  String get baseUrl;
}

class _RestApiProviderElement extends AutoDisposeProviderElement<RestApi>
    with RestApiRef {
  _RestApiProviderElement(super.provider);

  @override
  String get baseUrl => (origin as RestApiProvider).baseUrl;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
