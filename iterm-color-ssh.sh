# Adapted from https://medium.com/rahasak/change-terminal-color-when-ssh-e2a13ccee681
# Caleb Hyde, 2023-02-15
# REQUIRED: You will need to create a new "Prod" profile in iterm2, and change the color theme on that profile.
# NOTE: Enable "Use built-in Powerline glyphs" in all profiles used here
# tabc <profile name> do the profile change
# Refer to https://iterm2colorschemes.com/ for lots of suggestions
function tabc() {
  NAME="$@"; if [ -z "$NAME" ]; then NAME="Default"; fi
  echo -n -e "\033]50;SetProfile=$NAME\a"
}

function tpprod() {
    trap "tabc" INT EXIT
    tabc Prod
    tsh --proxy=teleport.opsv2.expel.io --user caleb.hyde --login caleb.hyde $*
}


# selecting different terminal profile according to ssh'ing host
# tabc <profile name> do the profile change
#   1. Production profile to production server (ssh eranga@production_box)
#   2. Staging profile to staging server(ssh eranga@staging_box)
#   3. Other profile to any other server(test server, amazon box etc)
function colorssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT

        if [[ "$*" =~ "prod*" ]]; then
            tabc Prod
        # elif [[ "$*" =~ "staging*" ]]; then
        #     tabc Staging
        else
            tabc Other
        fi
    fi
    ssh $*
}
compdef _ssh tabc=ssh

# creates an alias to ssh
# when execute ssh from the terminal it calls to colorssh function
alias ssh="colorssh"

# selecting different terminal profile according to ssh'ing host
# tabc <profile name> do the profile change
#   1. Production profile to production server (ssh eranga@production_box)
#   2. Staging profile to staging server(ssh eranga@staging_box)
#   3. Other profile to any other server(test server, amazon box etc)
function colorctx() {
    kubectx $*

    if [[ -n "$ITERM_SESSION_ID" ]]; then
        _ctx="$(awk '/^current-context/ {print $2}' ${KUBECONFIG:-$HOME/.kube/config})"
        case $_ctx in
        prod|services-prod)
            tabc "Prod"
            ;;
        *)
            tabc
            ;;
        esac
    fi
}

# Let's get this working before we:
alias kubectx=colorctx
colorctx staging
