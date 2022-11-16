{ pkgs, ... }:
let
  l = pkgs.lib // builtins;
  t = l.types ;

  complex_type = {
    options = {
      foo_1 = l.options.mkOption {
        description = "first argument of foo";
        type = t.listOf t.int;
      };

      foo_2 = l.options.mkOption {
        description = "first argument of foo";
        type = t.str;
      };
    };
  };

in
{
  options = {
    a = l.options.mkOption {
      description = "The a argument";
      type = t.int;
    };

    b = l.options.mkOption {
      description = "The b argument";
      type = t.str;
    };

    foo = l.options.mkOption {
      description = "A slightly complex type";
      type = t.submodule complex_type;
    };
  };

}

