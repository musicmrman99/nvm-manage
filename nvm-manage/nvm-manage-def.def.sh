# Default Variables
# --------------------------------------------------

nvm_manage__default__repo_url="https://github.com/creationix/nvm.git" # Change this if needed
nvm_manage__default__dir="$HOME/.nvm" # The location given in the NVM install instructions

# --------------------

nvm_manage__set_global_defaults() {
	nvm_manage__repo_url="$nvm_manage__default__repo_url"
	NVM_DIR="$nvm_manage__default__dir"
}

nvm_manage__print_globals() {
	printf "nvm-manage globals:\n"
	printf "nvm_manage__repo_url('%s')\n" "$nvm_manage__repo_url"
	printf '\n'
	printf "nvm globals:\n"
	printf "NVM_DIR('%s')\n" "$NVM_DIR"
}

# Support Functions
# --------------------------------------------------

nvm_manage__set_dir() {
	export NVM_DIR="$1"
}

nvm_manage__install() {
	# From the NVM readme (with edits):
	(
		git clone "$nvm_manage__repo_url" "$NVM_DIR"
		cd "$NVM_DIR"
		git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
	) && . "$NVM_DIR/nvm.sh"
}

nvm_manage__update() {
	# From the NVM readme (with edits):
	(
		cd "$NVM_DIR"
		git fetch --tags origin
		git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
	) && . "$NVM_DIR/nvm.sh"
}

nvm_manage__remove() {
	rm -rf "$NVM_DIR/.git"
	rm -r "$NVM_DIR"
}

nvm_manage__start() {
	if [ "$1" = "--bash-completion" ]; then
		. "$NVM_DIR/bash_completion"
	fi
	. "$NVM_DIR/nvm.sh" "$@"
}

# NVM Manager
# --------------------------------------------------

nvm_manage() {
	# The following is a modified version of this: http://stackoverflow.com/a/246128
	local nvm_manage_source
	local nvm_manage_dir

	nvm_manage_source="${BASH_SOURCE[0]}"

	# resolve $nvm_manage_source until the file is no longer a symlink
	while [ -h "$nvm_manage_source" ]; do
		nvm_manage_dir="$(cd -P "$( dirname "$nvm_manage_source" )" && pwd)"
		nvm_manage_source="$(readlink "$nvm_manage_source")"

		# if $nvm_manage_source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
		[[ $nvm_manage_source != /* ]] && nvm_manage_source="$nvm_manage_dir/$nvm_manage_source"
	done
	nvm_manage_dir="$(cd -P "$( dirname "$nvm_manage_source" )" && pwd)"

	# ------------------------------------------------------------

	local help=false
	while [ "$(printf '%s' "$1" | head -c 1)" = '-' ]; do
		case "$1" in
			'-h' | '-?' | '--help') help=true;;

			'--') shift; break;;
			*)
				echo "unrecognised option: '$1'"
				return 1
		esac
		shift
	done

	if [ "$help" = true ]; then
		cat "$nvm_manage_dir/help/nvm-manage.help.txt"
		return 0
	fi

	case "$1" in
	"globals")
		shift
		case "$1" in
		"reset") nvm_manage__set_global_defaults "$@";;
		"print") nvm_manage__print_globals "$@";;
		*)
			printf "Error: unrecognised globals command '%s'\n" "$1"
			return 1
			;;
		esac
		;;

	"set-dir") shift; nvm_manage__set_dir "$@";;
	"install") shift; nvm_manage__install "$@";;
	"update") shift; nvm_manage__update "$@";;
	"remove") shift; nvm_manage__remove "$@";;
	"start") shift; nvm_manage__start "$@";;

	*)
		printf "Error: unrecognised command '%s'\n" "$1"
		return 1
		;;
	esac
}

# This doesn't work in all shells (eg. dash, ash, etc. are known not to support '-' in function names),
# but where it does, I find it nicer to look at.
# ** Just remove it if it doesn't work in your shell. **
nvm-manage() {
	nvm_manage "$@"
}
