{ homeDirectory
, substituteAll
}:

{
  enable = true;
  autosuggestion = { enable = true; };
  enableCompletion = true;
  autocd = false;
  initContent = (builtins.readFile ./scripts/init.sh);
  shellAliases = (import ./aliases.nix { inherit homeDirectory; }).shell;
}
