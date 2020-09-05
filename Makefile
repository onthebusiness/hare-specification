all:
	xelatex specification.tex

clean:
	rm -f *.pdf *.aux *.toc *.log *.out

.PHONY: all clean
