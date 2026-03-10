---
trigger: model_decision
description: Use when creating, modifying, or working with features in lib/features/. Follow these patterns for data layer, domain layer, datasources, repositories, usecases, requests, and responses.
---

# Feature Architecture Rules

Follow these patterns when working with features in `lib/features/`.

## Directory Structure

```
lib/features/<feature_name>/
├── data/
│   ├── datasources/        # API/Database access
│   ├── mappers/            # Entity <-> Model conversions
│   ├── models/             # Data models (JSON serializable)
│   ├── repositories/       # Repository implementations
│   └── responses/          # API response wrappers
│
└── domain/
    ├── entities/           # Business entities (clean, no dependencies)
    ├── repositories/       # Abstract repository contracts
    ├── requests/           # Request DTOs with toBody() method
    └── usecases/           # Single-purpose use cases
```

---

## Domain Layer

### Entities (`domain/entities/`)
Clean business objects with no external dependencies.

```dart
class UserData {
  final String uuid;
  final String name;
  final String email;

  UserData({required this.uuid, required this.name, required this.email});
}
```

### Requests (`domain/requests/`)
DTOs for API calls. Always include `toBody()` or `toJsonBody()` method.

```dart
class SignInRequest {
  final String email;
  final String password;

  SignInRequest({required this.email, required this.password});

  Map<String, dynamic> toBody() {
    return {"email": email, "password": password};
  }
}
```

### Repository Contract (`domain/repositories/`)
Abstract class defining the contract. Returns `Either<Failure, Response>` using dartz.

```dart
abstract class AuthRepository {
  Future<Either<Failure, SignInResponse>> signIn({required SignInRequest request});
}
```

### Usecases (`domain/usecases/`)
Single-purpose classes with a `call()` method. Naming: `<Action>Usecase`.

```dart
class SignInUsecase {
  final AuthRepository repository;

  SignInUsecase({required this.repository});

  Future<Either<Failure, SignInResponse>> call({required SignInRequest request}) async {
    return await repository.signIn(request: request);
  }
}
```

---

## Data Layer

### Models (`data/models/`)
JSON-serializable versions of entities. Include `fromJson()` and `toJson()`.

```dart
class UserDataModel extends UserData {
  UserDataModel({required super.uuid, required super.name, required super.email});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      uuid: json['uuid'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {'uuid': uuid, 'name': name, 'email': email};
}
```

### Responses (`data/responses/`)
Wrap API responses. Include `fromJson()` or `fromResponse()` factory.

```dart
class SignInResponse {
  final String? message;
  final String token;
  final UserData user;

  SignInResponse({required this.message, required this.token, required this.user});

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      message: json['message'],
      token: json['token'],
      user: UserDataModel.fromJson(json['user']),
    );
  }
}
```

### DataSources (`data/datasources/`)
Two files per datasource: abstract contract + implementation.

**Abstract contract:**
```dart
abstract class AuthRemoteDataSource {
  Future<SignInResponse> signIn({required SignInRequest request});
}
```

**Implementation:**
```dart
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiManager apiManager;

  AuthRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<SignInResponse> signIn({required SignInRequest request}) async {
    final response = await apiManager().post(
      SupabaseEndpoints.rpc(SupabaseEndpoints.signInEndpoint),
      body: request.toBody(),
    );
    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);
    apiResponse.throwErrorIfExists();
    return SignInResponse.fromJson(apiResponse.data);
  }
}
```

**For new features:** Use placeholder implementations:
```dart
@override
Future<SomeResponse> someMethod({required SomeRequest request}) async {
  // TODO: Implement API call
  throw UnimplementedError();
}
```

### Repository Implementation (`data/repositories/`)
Implements the domain contract. Handles errors with `errorToFailure()`.

```dart
class AuthRepositoryImplement implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImplement({required this.remoteDataSource});

  @override
  Future<Either<Failure, SignInResponse>> signIn({required SignInRequest request}) async {
    try {
      final response = await remoteDataSource.signIn(request: request);
      return right(response);
    } on Exception catch (e) {
      return Left(errorToFailure(e));
    }
  }
}
```

### Mappers (`data/mappers/`)
Convert between entities and models when needed.

```dart
extension UserDataMapper on UserData {
  UserDataModel get toModel => UserDataModel(uuid: uuid, name: name, email: email);
}
```

---

## Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Entity | `<Name>` | `UserData` |
| Model | `<Name>Model` | `UserDataModel` |
| Request | `<Action>Request` | `SignInRequest` |
| Response | `<Action>Response` | `SignInResponse` |
| Usecase | `<Action>Usecase` | `SignInUsecase` |
| Repository (abstract) | `<Feature>Repository` | `AuthRepository` |
| Repository (impl) | `<Feature>RepositoryImplement` | `AuthRepositoryImplement` |
| DataSource (abstract) | `<Feature>RemoteDataSource` | `AuthRemoteDataSource` |
| DataSource (impl) | `<Feature>RemoteDataSourceImpl` | `AuthRemoteDataSourceImpl` |

---

## Key Imports

```dart
import 'package:dartz/dartz.dart';
import 'package:neuro_app/core/resources/errors/failures.dart';
import 'package:neuro_app/core/resources/errors/error_mapper.dart';
import 'package:neuro_app/core/services/api/api_manager.dart';
import 'package:neuro_app/core/services/api/api_constants.dart';
import 'package:neuro_app/core/services/api/responses/api_response.dart';
```

---

## Verification

When using this rules file, the agent MUST:

1. **In chat**: Start the response with "📐 Following feature-architecture rules" when creating or modifying feature files.

2. **In code**: Add this comment at the top of any NEW file created in `lib/features/`:
```dart
// feature-architecture: applied
```
