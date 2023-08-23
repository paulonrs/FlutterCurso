enum HttpError {
  badRequest, // 400
  notFound, // 404
  serverError, // 500
  unauthorized, // 401
  forbidden, // 403
}

final httpErrorMap = {
  400: HttpError.badRequest,
  401: HttpError.unauthorized,
  404: HttpError.notFound,
  403: HttpError.forbidden,
  500: HttpError.serverError,
};
