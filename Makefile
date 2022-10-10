.PHONY: default clean cleaner feedback check_template gitlab_check

default:
	make -C notes
	make -C slides

clean:
	make -C notes clean
	make -C slides clean
	rm -rf feedback.html feedback_link.yaml feedback.Rmd libs/ style.css

cleaner:
	make -C notes cleaner
	make -C slides cleaner

check_template:
	Rscript -e "jrNotes2::check_template()"

container:
	docker pull registry.gitlab.com/jumpingrivers/training/materials:main
	docker run -ti --rm -v ${PWD}:/root/ -w /root/ --env GITLAB_CI=true registry.gitlab.com/jumpingrivers/training/materials:main /bin/bash

feedback:
ifeq ("x", "x${GITLAB_CI}")
		virtualenv -p python3 venv
		( \
			. venv/bin/activate; \
			pip install tform; \
			tform create-from-config; \
		)
		Rscript -e 'jrPresentation2::create_feedback(); rmarkdown::render("feedback.Rmd")'
endif

gitlab_check:
	make check_template
	make -C notes final
	make -C slides
	make -C slides final
