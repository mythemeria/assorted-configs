alias ls='ls --color=auto'
alias lla='ls -l -a'
alias la='ls -a'
alias ll='ls -l'
alias grep='grep --color=auto'
alias fuck='sudo "$BASH" -c "$(history -p !!)"'
alias ff='firefox'
alias galc='galculator'
alias calc='galculator'
alias connect-tv='xrandr --output HDMI-1-0 --auto --scale 1 --right-of eDP-1 && feh --bg-fill /home/izi/Pictures/bg/bg.png'
alias br-high='echo 250 | sudo tee /sys/class/backlight/*/brightness'
alias br-low='echo 30 | sudo tee /sys/class/backlight/*/brightness'
alias newvenv='python -m venv venv && source ./venv/bin/activate && pip install --upgrade pip'