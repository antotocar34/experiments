{ pkgs }:

# This is the function we want to modularize
# let
#   f = {
#     a, # should have type int
#     b  # should have type str
#     foo  # should have more complex type
#   }:
#   {
#     c = a + 2;
#     d = b;
#     inherit foo;
#   };
# in 
#   f

# Implementation
let
  f = { 
    a,
    b,
    foo
  }@args:
  let
    m = pkgs.lib.evalModules { 
      modules = [ 
        {imports = [./f_args.nix];}
        { config = args; }
    ] ;
      specialArgs = { inherit pkgs; };
    } 
    ;

  in
    {
      c = m.config.a + 2;
      d = m.config.b ;
      inherit (m.config) foo;
    }
    ;
in
  f
