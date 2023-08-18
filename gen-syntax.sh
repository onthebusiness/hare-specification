#!/bin/sh
set -eu

printf '%s\n' '\specappendix{Language syntax summary}'

# get all language input files in the order that they appear in the spec
grep '^\\input' language.tex \
		| sed -E 's/^\\input\{(.*)\}/\1/' \
		| while read -r input; do
	in_grammar=
	section=
	# copy lines within a grammar block, and discard everything else
	while read -r line; do
		if printf '%s\n' "$line" | grep -q '^\\specsection'; then
			section="$(printf '%s\n' "$line" \
				| sed -E 's/^\\specsection/\\specappxsection/')"
		fi
		if [ -n "$in_grammar" ]; then
			printf '%s\n' "$line"
			if [ "$line" = '\end{grammar}' ]; then
				in_grammar=
			fi
		elif [ "$line" = '\begin{grammar}' ]; then
			if [ -n "$section" ]; then
				printf '\n%s\n\n' "$section"
				section=
			fi
			printf '%s\n' "$line"
			in_grammar=1
		fi
	done <"$input"
done
