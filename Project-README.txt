README for the class project.

Operating instructions:
- place all the Samsung ".txt" files in the same directory as the "run_analysis.R" file.
- type: source("run_analysis.R") to run the script. wait few minutes
- to observe the top of the summary data type: head(summary)
- to observe the bottom of hte summary file type: tail(summary)

The "run_analysis.R" script has embedded comments that explain the steps and sometime provide
altenative ways to acheive the result

- variables of interest that may help you step through the code:
- xdata: merged "x_train" and "x_test" files
- ydata and sdata correspond to merge y and s files
- sub_data merges the 3 files above to one large data.frame
- I them step throug the cleanup and project tasks. all these step are explained in the comments


- there are 79 features names. You can observe these by typing: clean_names
- I picked only names that include mean() or std()
- names were further cleaned by allowing max of a single ".", and removal of "()"
- I don't understand the meaning of these features and did not bother to read about them

Enjoy :)