.POSIX:

all: specification.pdf

specification.pdf: specification.ps
	ps2pdf -dNOSAFER -dALLOWPSTRANSPARENCY specification.ps

specification.ps: specification.dvi
	dvips specification.dvi

specification.dvi: *.tex language/*.tex
	while latex specification.tex | tee /dev/fd/2 | grep "Label(s) may have changed"; do true; done

clean:
	rm -f *.pdf *.dvi *.ps *.aux *.toc *.log *.out

watch:
	while inotifywait \
		-e close_write . \
		-e close_write language/; \
		do make; done

.PHONY: clean watch
