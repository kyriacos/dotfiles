# Source this file. Tell Node to use the macOS certificate store when a
# Cloudflare Gateway CA is installed. No certificate is copied to disk.
# The VS Code CLI ignores NODE_OPTIONS; bin/code-shim/code handles that.

if printf '%s' "${NODE_OPTIONS-}" | grep -q -- '--use-system-ca'; then
	return 0 2>/dev/null || exit 0
fi

if ! command -v security >/dev/null 2>&1; then
	return 0 2>/dev/null || exit 0
fi

if security find-certificate -c "Gateway CA - Cloudflare" /Library/Keychains/System.keychain >/dev/null 2>&1; then
	if [ -n "${NODE_OPTIONS-}" ]; then
		export NODE_OPTIONS="$NODE_OPTIONS --use-system-ca"
	else
		export NODE_OPTIONS="--use-system-ca"
	fi
fi
