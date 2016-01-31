{-# LANGUAGE CPP #-}

fzf, tmux :: String
fzf = FZF_DIR ++ "/bin/fzf"
tmux = FZF_DIR ++ "/bin/tmux"

data Units = Actual | Percent
data Direction = Up | Down
data Layout = Layout Direction Int Units

data Options = 

main = do
    putStrLn fzf
    putStrLn tmux
