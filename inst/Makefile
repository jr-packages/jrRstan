.SUFFIXES: .tex .pdf .Rnw .R

PRACS = practical1 practical2 
SOLS = solutions1 solutions2
ALL =  $(PRACS)  $(SOLS)

SOLSPDF = $(SOLS:=.pdf)
PRACSPDF = $(PRACS:=.pdf)
ALLPDF = $(ALL:=.pdf)

PRACSRNW =  $(PRACS:=.Rnw)
SOLSRNW =  $(SOLS:=.Rnw)
ALLRNW = $(ALL:=.Rnw)

TEX = $(ALL:=.tex) 
RFILES = $(ALL:=.R)
RNWFILES = $(All:=.Rnw)

all: $(PRACSPDF) $(SOLSPDF)
	$(MAKE) -f Makefile solutions*.Rnw
#	$(MAKE) -f Makefile sols

solutions%.Rnw: $(PRACSPDF)
	## Copy practical file to solutions
	$(foreach var, \
		$(PRACSRNW), \
		cp $(var) $(subst practical, solutions, $(var);))
	## Updated to show results
	$(foreach var, \
		$(SOLSRNW), \
		sed -i "4s/.*/results='show';echo=TRUE/" $(var);)

R: $(RFILES)

view: all
	xpdf $(ALL).pdf &


.Rnw.pdf:
	sed -i "1s/.*/%\\\VignetteIndexEntry{$*}/" $*.Rnw
	Rscript  -e "require(knitr); knit('$*.Rnw', output='$*.tex')"
	sed -i 's/PY{err}{|}/PY{o}{|}/g' $*.tex
	pdflatex $*.tex
	pdflatex $*.tex
	cp $*.pdf ../vignettes/

#.tex.pdf:
#	rubber --pdf $*.tex

clean:
	rm -fvr knitr_figure knitr_cache && \
	rm -fv $(ALLPDF) $(TEX) $(RFILES)
	rm -fv *.aux *.dvi *.log *.toc *.bak *~ *.blg *.bbl *.lot *.lof
	rm -fv  *.nav *.snm *.out *.pyc \#*\# _region_* _tmp.* *.vrb
	rm -fv Rplots.pdf *.RData d.csv.gz
	rm -fv solutions*.Rnw

cleaner:
	make clean
	rm -fv figure
	rm -fv cache
	rm -fv ../vignettes/*.pdf
	#rm -fvr auto
