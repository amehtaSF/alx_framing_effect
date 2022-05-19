
DIR_PROJECT = ./
DIR_ANALYSIS = ./analysis
DIR_DATA = ./data
DIR_RAW = $(DIR_DATA)/raw
DIR_PROC = $(DIR_DATA)/proc
DIR_RESULTS = ./results

# generate html report from Rmd file
RENDER = Rscript -e "rmarkdown::render('$<')"

# generate html report from Rmd file and move it to "results" directory
RENDER_TO_RESULTS = $(RENDER); mv $(<:.Rmd=.html) $(DIR_RESULTS)

# execute Rmd file without generating report
SOURCE_RMD_NO_REPORT = Rscript -e 'knitr::knit("$<", output = tempfile())'


# Processed data files
DATA_TARGETS = ##########################################

# Reports
REPORT_TARGETS = ########################################

# Recursively search all subdirectories of the project for prerequisites
# Can add to this to search other directories as well
# if a file that is listed as a target or prerequisite does not exist in the current directory, make searches the directories listed in VPATH for a file with that name. If a file is found in one of them, that file may become the prerequisite (see below). Rules may then specify the names of files in the prerequisite list as if they all existed in the current directory
# see https://www.gnu.org/software/make/manual/html_node/General-Search.html
VPATH = $(shell find . -type d)


# -- Special Make commands -- #
# all: $(DATA_TARGETS) $(REPORT_TARGETS)
	

FORCE:

clean:
	find results -name "*.html" -type f -delete


# -- Analyze data -- #

analysis: results/analysis.html

$(DIR_RESUTS)/%.html: src/analysis/%.Rmd
	$(RENDER_TO_RESULTS)

# -- Preprocess data -- #

preproc: data/proc/%.csv

$(DIR_PROC)/%.csv: src/preproc/initial_preproc.Rmd
	$(SOURCE_RMD_NO_REPORT)


# -- Gather data -- #

# gather: FORCE
# 	bash src/gather/gather.sh;
	
# doc/codebook.xlsx: src/gather/gather.sh
# 	bash src/gather/gather.sh;

# data/raw/%.csv: src/gather/gather.sh
# 	bash src/gather/gather.sh;



# -- Reference -- #

# Useful automatic variables:
# $@       the name of the target
# $<       the name of the first prerequisite
# $^       the names of all prerequisites of current rule
# $(@D)    the directory part of the target
# $(@F)    the file part of the target
# $(<D)    the directory part of the first prerequisite
# $(<F)    the file part of the first prerequisite