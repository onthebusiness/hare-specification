all:
	xelatex specification.tex

clean:
	rm -f *.pdf *.aux *.toc *.log *.out

watch:
	while inotifywait \
		-e close_write . \
		-e close_write language/; \
		do make; done

.PHONY: all clean
