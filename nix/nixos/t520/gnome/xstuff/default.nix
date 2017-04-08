{ writeScript, writeTextFile }:

let
  script = writeScript "do-xstuff" ''
    #!/bin/sh
    xmodmap ${./Xmodmap}
    xset r rate 200 50
  '';

in writeTextFile {
  name = "xstuff";
  destination = "/share/applications/xstuff.desktop";
  text = ''
    [Desktop Entry]
    Name=xstuff
    GenericName=xstuff
    Comment=xstuff
    Exec=${script}
    Terminal=false
    Type=Application
    X-GNOME-Autostart-enabled=true
  '';
}
