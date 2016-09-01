{ ... }:

{

  services.vmwareGuest.enable = true;

  boot.kernel.sysctl = {
    "kernel.core_pattern" = "|/da/ToolsAndLibs/CodingScripts/zipcore.sh %p %r %u %s";
    "kernel.core_pipe_limit" = 64;
  };

}
