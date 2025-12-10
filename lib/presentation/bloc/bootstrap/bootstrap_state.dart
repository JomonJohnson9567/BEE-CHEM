 
 
enum BootstrapStatus {
 
  checking,

  
  authenticated,

  
  unauthenticated,
}
 
class BootstrapState {
  const BootstrapState({this.status = BootstrapStatus.checking});

  final BootstrapStatus status;

 
  BootstrapState copyWith({BootstrapStatus? status}) {
    return BootstrapState(status: status ?? this.status);
  }
 
  bool get isChecking => status == BootstrapStatus.checking;
  bool get isAuthenticated => status == BootstrapStatus.authenticated;
  bool get isUnauthenticated => status == BootstrapStatus.unauthenticated;
}
