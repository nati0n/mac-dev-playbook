#!/usr/bin/env bash
# install.sh — macOS app and tool bootstrapper
# Requires: Homebrew (brew), mas-cli (brew install mas)
# Usage: bash install.sh

set -euo pipefail

# ── helpers ───────────────────────────────────────────────────────────────────

brew_install() {
    if brew list --formula "$1" &>/dev/null; then
        echo "  [skip] $1 already installed"
    else
        brew install "$1"
    fi
}

cask_install() {
    if brew list --cask "$1" &>/dev/null; then
        echo "  [skip] $1 already installed"
    else
        brew install --cask "$1"
    fi
}

mas_install() {
    local id="$1" name="$2"
    if mas list | grep -q "^${id}"; then
        echo "  [skip] ${name} already installed"
    else
        mas install "$id"
    fi
}

# ── preflight ─────────────────────────────────────────────────────────────────

if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Install it first: https://brew.sh"
    exit 1
fi

if ! command -v mas &>/dev/null; then
    echo "Installing mas (Mac App Store CLI)..."
    brew install mas
fi

echo ""
echo "==> Tapping extras"
brew tap homebrew/cask-fonts 2>/dev/null || true

# ═════════════════════════════════════════════════════════════════════════════
# FORMULAE (CLI tools / libraries)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "==> Installing formulae"

brew_install aom
brew_install apr
brew_install apr-util
brew_install argon2
brew_install autoconf
brew_install bash-completion
brew_install binwalk
brew_install brotli
brew_install c-ares
brew_install ca-certificates
brew_install certifi
brew_install curl
brew_install dagger
brew_install dav1d
brew_install dockutil
brew_install doxygen
brew_install fontconfig
brew_install freetds
brew_install freetype
brew_install fzf
brew_install gd
brew_install gettext
brew_install gh
brew_install giflib
brew_install gifsicle
brew_install git
brew_install gmp
brew_install gnupg
brew_install go
brew_install gnutls
brew_install highway
brew_install httpie
brew_install icu4c@78
brew_install imath
brew_install iperf
brew_install jpeg-turbo
brew_install jpeg-xl
brew_install krb5
brew_install kubeconform
brew_install libassuan
brew_install libavif
brew_install libdeflate
brew_install libevent
brew_install libgcrypt
brew_install libgpg-error
brew_install libiconv
brew_install libidn2
brew_install libksba
brew_install liblinear
brew_install libnghttp2
brew_install libnghttp3
brew_install libngtcp2
brew_install libpng
brew_install libpq
brew_install libsodium
brew_install libssh2
brew_install libtasn1
brew_install libtiff
brew_install libtool
brew_install libunistring
brew_install libusb
brew_install libuv
brew_install libyubikey
brew_install libzip
brew_install little-cms2
brew_install lua
brew_install luajit
brew_install lz4
brew_install m4
brew_install mpdecimal
brew_install ncurses
brew_install net-snmp
brew_install nettle
brew_install nmap
brew_install node
brew_install npth
brew_install nvm
brew_install oniguruma
brew_install opencode
brew_install openexr
brew_install openjph
brew_install openldap
brew_install openssl@3
brew_install p11-kit
brew_install p7zip
brew_install pcre2
brew_install php
brew_install pinentry
brew_install pngpaste
brew_install powerlevel10k
brew_install pure
brew_install pv
brew_install python@3.14
brew_install readline
brew_install ripgrep
brew_install rtmpdump
brew_install simdjson
brew_install sqlite
brew_install ssh-copy-id
brew_install sshpass
brew_install telnet
brew_install tidy-html5
brew_install unbound
brew_install unixodbc
brew_install uvwasi
brew_install webp
brew_install wget
brew_install wrk
brew_install xz
brew_install zsh
brew_install zsh-async
brew_install zsh-history-substring-search
brew_install zstd

# ═════════════════════════════════════════════════════════════════════════════
# CASKS (GUI apps installable via Homebrew)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "==> Installing casks"

cask_install 1password
cask_install adobe-acrobat-reader
cask_install anki
cask_install bartender
cask_install chromedriver
cask_install cool-retro-term
cask_install cyberduck
cask_install discord
cask_install docker-desktop
cask_install firefox
cask_install ghostty
cask_install gitkraken
cask_install handbrake                  # NB: cask is 'handbrake', not 'handbrake-app'
cask_install insta360-link-controller
cask_install keka
cask_install kitty
cask_install licecap
cask_install lm-studio
cask_install lunar
cask_install ollama
cask_install opencode-desktop
cask_install orion
cask_install scroll-reverser
cask_install sequel-ace
cask_install signal
cask_install soundsource
cask_install transmission
cask_install transmit
cask_install typora
cask_install visual-studio-code
cask_install vivaldi
cask_install vlc
cask_install vmware-fusion
cask_install wireshark                  # NB: cask is 'wireshark', not 'wireshark-app'

# ── apps that may need manual/vendor install ──────────────────────────────────
# The following were found in /Applications but have no brew formula or cask,
# or require a license / enterprise deployment:
#
#   Binary Ninja       — https://binary.ninja (license required)
#   GlobalProtect      — deployed by your org via MDM / Jamf
#   iTerm2             — cask_install iterm2  (add if desired)
#   Mimestream         — cask_install mimestream
#   Open WebUI         — run via Docker or pip
#   Sublime Text       — cask_install sublime-text
#   Sublime Merge      — cask_install sublime-merge
#   Alfred             — cask_install alfred
#   AppCleaner         — cask_install appcleaner
#   The Unarchiver     — MAS (see below) or cask_install the-unarchiver
#   ChatGPT            — cask_install chatgpt
#   Claude             — cask_install claude
#   SwiftBar           — cask_install swiftbar
#   Fantastical        — MAS (see below)
#   Magnet             — MAS (see below)
#   Amphetamine        — MAS (see below)
#   Slack              — cask_install slack  (or MAS)
#   Zoom               — cask_install zoom
#   Microsoft Office   — cask_install microsoft-office (or via your org)
#   OneDrive           — cask_install onedrive
#   YubiKey Manager    — cask_install yubikey-manager
#   Windows App        — MAS (see below)
#   Avaya apps         — vendor installer
#   JamfProtect        — deployed by Jamf
#   SentinelOne        — deployed by your org

# ═════════════════════════════════════════════════════════════════════════════
# MAS (Mac App Store)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "==> Installing Mac App Store apps"

# These IDs are verified; confirm with: mas search <appname>
mas_install 1569813296  "1Password for Safari"
mas_install 904280696   "Things 3"                   # example placeholder
mas_install 1475387142  "Tailscale"                  # example placeholder

# Common apps from your /Applications list that live in the MAS:
mas_install 1614856931  "Mimestream"
mas_install 1352778147  "Toolbox for Word"           # if applicable; remove if not
mas_install 1147396723  "WhatsApp"                   # if applicable; remove if not
mas_install 441258766   "Magnet"
mas_install 937984704   "Amphetamine"
mas_install 975937182   "Fantastical"
mas_install 1107421413  "1Blocker"                   # remove if not used
mas_install 1397180934  "Desktop Curtain"            # remove if not used
mas_install 1147560405  "Kagi for Safari"
mas_install 1444383602  "GoodLinks"                  # remove if not used
mas_install 1295203466  "Microsoft Remote Desktop"   # aka Windows App
mas_install 1232658672  "The Unarchiver"
mas_install 1529448980  "Reeder."                    # remove if not used
mas_install 1480068668  "Mango 5Star"                # remove if not used

# ── Microsoft Office (MAS versions) ──────────────────────────────────────────
# Install individually or as a suite via your org's volume license.
# MAS IDs shown here are the standalone consumer versions:
mas_install 462054704   "Microsoft Word"
mas_install 462058435   "Microsoft Excel"
mas_install 462062816   "Microsoft PowerPoint"
mas_install 985367838   "Microsoft Outlook"
mas_install 784801555   "Microsoft OneNote"
mas_install 1660836954  "Microsoft Teams"            # Teams new

# ═════════════════════════════════════════════════════════════════════════════
# OPTIONAL EXTRAS (uncomment as needed)
# ═════════════════════════════════════════════════════════════════════════════

# cask_install alfred
# cask_install appcleaner
# cask_install chatgpt
# cask_install claude
# cask_install iterm2
# cask_install mimestream
# cask_install onedrive
# cask_install slack
# cask_install sublime-merge
# cask_install sublime-text
# cask_install swiftbar
# cask_install the-unarchiver
# cask_install yubikey-manager
# cask_install zoom
# cask_install microsoft-office

echo ""
echo "==> Done. Run 'brew cleanup' to reclaim disk space."
