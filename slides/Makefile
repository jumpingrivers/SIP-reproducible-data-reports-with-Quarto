########################################
# **Slides makefile**
# This file is identical for all slides
# Any changes will get over written
# If you need to change anything, alter
# jrNotes
#######################################
.PHONY: default final feedback connect namer clean cleaner

INCLUDES = $(shell find . -maxdepth 1 -name '*.Rmd')
NAMES = $(basename $(INCLUDES))
HTML = $(NAMES:=.html)
default: $(HTML)

$(HTML): $(INCLUDES)
	Rscript -e 'jrPresentation2::render()'

final: $(HTML)
	Rscript -e "jrPresentation2::create_final()"

# Pushing to connect
connect: $(HTML)
	Rscript -e "jrPresentation2::upload_slides()"

# Rename chunks
namer:
	Rscript -e "namer::name_dir_chunks('.')"

clean:
	Rscript -e "jrNotes2::clean()"

cleaner: clean
	Rscript -e "jrNotes2::cleaner()"
	Rscript -e "jrPresentation2::clean_site()"
