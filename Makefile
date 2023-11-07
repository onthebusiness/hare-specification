.POSIX:

all: specification.pdf

specification.pdf: specification.ps
	ps2pdf -dNOSAFER -dALLOWPSTRANSPARENCY specification.ps

specification.ps: specification.dvi
	dvips specification.dvi

specification.dvi: *.tex language/*.tex appendix/syntax.tex
	while latex -file-line-error specification.tex | tee /dev/fd/2 | grep "Label(s) may have changed"; do true; done

appendix/syntax.tex: language/*.tex gen-syntax.sh
	mkdir -p appendix
	sh gen-syntax.sh > $@

clean:
	rm -f *.pdf *.dvi *.ps *.aux *.toc *.log *.out appendix/syntax.tex

watch:
	while inotifywait \
		-e close_write . \
		-e close_write language/; \
		do make; done

.PHONY: clean watch
