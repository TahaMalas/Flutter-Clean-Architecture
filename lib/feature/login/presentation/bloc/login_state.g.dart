// GENERATED CODE - DO NOT MODIFY BY HAND

part of login_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginState extends LoginState {
  @override
  final String password;
  @override
  final String number;
  @override
  final bool isRememberMe;
  @override
  final String forgotPasswordNumber;
  @override
  final int error;
  @override
  final int forgotPasswordError;
  @override
  final bool isPasswordError;
  @override
  final bool isEmailError;
  @override
  final bool isLoading;
  @override
  final bool isSuccess;
  @override
  final bool isInitial;

  factory _$LoginState([void Function(LoginStateBuilder) updates]) =>
      (new LoginStateBuilder()..update(updates)).build();

  _$LoginState._(
      {this.password,
      this.number,
      this.isRememberMe,
      this.forgotPasswordNumber,
      this.error,
      this.forgotPasswordError,
      this.isPasswordError,
      this.isEmailError,
      this.isLoading,
      this.isSuccess,
      this.isInitial})
      : super._() {
    if (password == null) {
      throw new BuiltValueNullFieldError('LoginState', 'password');
    }
    if (number == null) {
      throw new BuiltValueNullFieldError('LoginState', 'number');
    }
    if (isRememberMe == null) {
      throw new BuiltValueNullFieldError('LoginState', 'isRememberMe');
    }
    if (forgotPasswordNumber == null) {
      throw new BuiltValueNullFieldError('LoginState', 'forgotPasswordNumber');
    }
    if (error == null) {
      throw new BuiltValueNullFieldError('LoginState', 'error');
    }
    if (forgotPasswordError == null) {
      throw new BuiltValueNullFieldError('LoginState', 'forgotPasswordError');
    }
    if (isPasswordError == null) {
      throw new BuiltValueNullFieldError('LoginState', 'isPasswordError');
    }
    if (isEmailError == null) {
      throw new BuiltValueNullFieldError('LoginState', 'isEmailError');
    }
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('LoginState', 'isLoading');
    }
    if (isSuccess == null) {
      throw new BuiltValueNullFieldError('LoginState', 'isSuccess');
    }
    if (isInitial == null) {
      throw new BuiltValueNullFieldError('LoginState', 'isInitial');
    }
  }

  @override
  LoginState rebuild(void Function(LoginStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginStateBuilder toBuilder() => new LoginStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginState &&
        password == other.password &&
        number == other.number &&
        isRememberMe == other.isRememberMe &&
        forgotPasswordNumber == other.forgotPasswordNumber &&
        error == other.error &&
        forgotPasswordError == other.forgotPasswordError &&
        isPasswordError == other.isPasswordError &&
        isEmailError == other.isEmailError &&
        isLoading == other.isLoading &&
        isSuccess == other.isSuccess &&
        isInitial == other.isInitial;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, password.hashCode),
                                            number.hashCode),
                                        isRememberMe.hashCode),
                                    forgotPasswordNumber.hashCode),
                                error.hashCode),
                            forgotPasswordError.hashCode),
                        isPasswordError.hashCode),
                    isEmailError.hashCode),
                isLoading.hashCode),
            isSuccess.hashCode),
        isInitial.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginState')
          ..add('password', password)
          ..add('number', number)
          ..add('isRememberMe', isRememberMe)
          ..add('forgotPasswordNumber', forgotPasswordNumber)
          ..add('error', error)
          ..add('forgotPasswordError', forgotPasswordError)
          ..add('isPasswordError', isPasswordError)
          ..add('isEmailError', isEmailError)
          ..add('isLoading', isLoading)
          ..add('isSuccess', isSuccess)
          ..add('isInitial', isInitial))
        .toString();
  }
}

class LoginStateBuilder implements Builder<LoginState, LoginStateBuilder> {
  _$LoginState _$v;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  String _number;
  String get number => _$this._number;
  set number(String number) => _$this._number = number;

  bool _isRememberMe;
  bool get isRememberMe => _$this._isRememberMe;
  set isRememberMe(bool isRememberMe) => _$this._isRememberMe = isRememberMe;

  String _forgotPasswordNumber;
  String get forgotPasswordNumber => _$this._forgotPasswordNumber;
  set forgotPasswordNumber(String forgotPasswordNumber) =>
      _$this._forgotPasswordNumber = forgotPasswordNumber;

  int _error;
  int get error => _$this._error;
  set error(int error) => _$this._error = error;

  int _forgotPasswordError;
  int get forgotPasswordError => _$this._forgotPasswordError;
  set forgotPasswordError(int forgotPasswordError) =>
      _$this._forgotPasswordError = forgotPasswordError;

  bool _isPasswordError;
  bool get isPasswordError => _$this._isPasswordError;
  set isPasswordError(bool isPasswordError) =>
      _$this._isPasswordError = isPasswordError;

  bool _isEmailError;
  bool get isEmailError => _$this._isEmailError;
  set isEmailError(bool isEmailError) => _$this._isEmailError = isEmailError;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  bool _isSuccess;
  bool get isSuccess => _$this._isSuccess;
  set isSuccess(bool isSuccess) => _$this._isSuccess = isSuccess;

  bool _isInitial;
  bool get isInitial => _$this._isInitial;
  set isInitial(bool isInitial) => _$this._isInitial = isInitial;

  LoginStateBuilder();

  LoginStateBuilder get _$this {
    if (_$v != null) {
      _password = _$v.password;
      _number = _$v.number;
      _isRememberMe = _$v.isRememberMe;
      _forgotPasswordNumber = _$v.forgotPasswordNumber;
      _error = _$v.error;
      _forgotPasswordError = _$v.forgotPasswordError;
      _isPasswordError = _$v.isPasswordError;
      _isEmailError = _$v.isEmailError;
      _isLoading = _$v.isLoading;
      _isSuccess = _$v.isSuccess;
      _isInitial = _$v.isInitial;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LoginState;
  }

  @override
  void update(void Function(LoginStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginState build() {
    final _$result = _$v ??
        new _$LoginState._(
            password: password,
            number: number,
            isRememberMe: isRememberMe,
            forgotPasswordNumber: forgotPasswordNumber,
            error: error,
            forgotPasswordError: forgotPasswordError,
            isPasswordError: isPasswordError,
            isEmailError: isEmailError,
            isLoading: isLoading,
            isSuccess: isSuccess,
            isInitial: isInitial);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
