{ homeDirectory
, substituteAll
}:

{
  enable = true;
  autosuggestion = { enable = true; };
  enableCompletion = true;
  autocd = false;
  initExtra = (builtins.readFile ./scripts/init.sh);
  shellAliases = (import ./aliases.nix { inherit homeDirectory; }).shell;
}
