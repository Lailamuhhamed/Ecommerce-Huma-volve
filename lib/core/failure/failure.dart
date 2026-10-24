
abstract class Failure {
  final String message;
  const Failure(this.message);
}

// 1. خطأ قادم من السيرفر (API Errors, Status Codes like 400, 404, 500)
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// 2. خطأ الاتصال بالإنترنت (لا يوجد شبكة)
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

// 3. خطأ في الكاش أو التخزين المحلي (Local Database / SharedPreferences)
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache failure occurred']);
}

// 4. خطأ غير متوقع
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'An unexpected error occurred']);
}