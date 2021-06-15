function tmx 
  set SG_UI "~/Work/saint_gobain/angular"
  set SG_BACK "~/Work/saint_gobain/node"

  set PMDASH_UI "~/Work/pmdash/pmdash_ui"
  set PMDASH_BACKEND "~/Work/pmdash/pmdash_backend"

  function createSession
    set session $argv[1]
    set window $argv[2]
    set cmd "tmux new -s $session -d -n $window $argv[3..-1]"
    echo "Creating Session $session deamonized"
    eval $cmd
  end

  function createWindow
    set session $argv[1]
    set window $argv[2]
    set hasWindow (tmux list-windows -t $session | grep "$window")
    if test -z $hasWindow
      set cmd "tmux neww -t $session: -n $window -d"
      if test (count $argv[3..-1]) -gt 0
        set cmd "$cmd $argv[3..-1]"
      end
      echo "Creating Window (\$hasWindow\): $cmd"
      eval $cmd
    end
  end

  while test (count $argv) -gt 0;
    set curr $argv[1]
    set --erase argv[1]
    switch $curr
      case "-s"
        createSession sg sg_ui -c $SG_UI
        createWindow sg sg_back -c $SG_BACK
      case "-p"
        createSession sg pmdash_ui -c $PMDASH_UI
        createWindow sg pmdash_backend -c $PMDASH_BACKEND
    end
  end
end
