{ attoparsec }:
    { name = "test";
      src = ./.;
      haskellInputs = [ attoparsec ];
      cpp = { WHO = "me"; };
    }
