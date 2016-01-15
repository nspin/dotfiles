{ attoparsec }:
{ name = "test";
  src = ./.;
  libs = [ attoparsec ];
  cpp = { _NAME = "name";
          _OTHER = "thing";
        };
}
