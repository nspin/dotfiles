{ mars, attoparsec }:
{ name = "hscript-test";
  src = ./.;
  libs = [ attoparsec ];
  cpp = { _MARS = mars;
        };
}
