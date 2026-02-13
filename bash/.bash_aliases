# This file (~/.bash_aliases) is sourced by Ubuntu's default ~/.bashrc

# ============================================================================
# Tool Aliases
# ============================================================================
alias bat=batcat
alias fd=fdfind

# ============================================================================
# Navigation Shortcuts
# ============================================================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# ============================================================================
# File Operations
# ============================================================================
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lh='ls -lh'
alias lt='ls -ltr'  # Sort by time, most recent last

# ============================================================================
# Git Shortcuts
# ============================================================================
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gb='git branch'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate'

# ============================================================================
# Development Shortcuts
# ============================================================================
alias py='python3'
alias k='kubectl'
alias d='docker'
alias dc='docker-compose'

# ============================================================================
# Utility Aliases
# ============================================================================
alias c='clear'
alias h='history'
alias ports='netstat -tulanp'
