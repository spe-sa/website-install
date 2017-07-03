#!/bin/bash
# script to install or pull code from git repo

# constants (change if not using default environment setup)
DB="django"
DB_HOST="localhost"
DB_USER="root"
DB_PSSWORD="root"

debug () {
		if [ "$_opt_verbose" = "true" ] ; then
        	# log all messages
        	echo $1;
        fi
}

show_help() {
    echo "usage: sync-db.sh [-h?][-v][-f]"
    echo "     -h or ?: show usage help"
    echo "     -v: show verbose logging"
    echo ""
}

# parse all options using getargs...
# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

while getopts "h?vf" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    v)  _opt_verbose=true
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

_opt_arg=$@
debug "options: "
debug "verbose:$_opt_verbose"
debug "argument: $_opt_arg"
debug ""

echo "You have requested to reload the website database.  All existing pages and data will be over-written."
echo 'Are you sure? [y/N]'
read _user_answer
debug "user answer: [$_user_answer]"
echo ""
if [[ "$_user_answer" != "y" && "$_user_answer" != "Y" ]]; then
    echo " "
    echo "done"
    exit 0
fi
# todo: mysql ... [get the rest of the command here]"
echo "database restored"
echo "done"