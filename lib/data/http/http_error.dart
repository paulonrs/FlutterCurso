enum HttpError {
  badRequest, // 400
  unauthorized, // 401
  forbidden, // 403
  notFound, // 404
  serverError, // 500
}

final httpErrorMap = {
  400: HttpError.badRequest,
  401: HttpError.unauthorized,
  403: HttpError.forbidden,
  404: HttpError.notFound,
  500: HttpError.serverError,
};
