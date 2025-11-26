{ homeDirectory }:

{
  shell = {    # fzf based alias
    preview = "fzf --preview 'bat --color \"always\" {}'";
  };
}
