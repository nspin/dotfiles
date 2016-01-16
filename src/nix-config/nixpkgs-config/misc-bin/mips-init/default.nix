{ mars, attoparsec }:
{ name = "mips-init";
  src = ./.;
  libs = [ attoparsec ];
  cpp = { _MARS = mars;
        };
}
