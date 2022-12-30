.POSIX:

all: specification.pdf

specification.pdf: specification.ps
	ps2pdf -dNOSAFER -dALLOWPSTRANSPARENCY specification.ps

specification.ps: specification.dvi
	dvips specification.dvi

specification.dvi: specification.tex
	latex specification.tex

clean:
	rm -f *.pdf *.dvi *.ps *.aux *.toc *.log *.out

watch:
	while inotifywait \
		-e close_write . \
		-e close_write language/; \
		do make; done

.PHONY: all clean watch
