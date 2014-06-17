# Read Me

This repo contains the script to tidy up the wearable computing data set captured from Samsung Galaxy S3 (see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and the cleaned up data set.

## Files in this repo 

The repo mainly contains the following files:

* README.md: this file, briefly introduce this repo
* run_analysis.R: the R script that tidy up the data set into tidyset.txt
* tidyset.txt: the txt file contains the cleaned up data set
* CodeBook.md: the markdown document describes the cleaned up data set variables and how data is transfromed from the original set to the cleaned up set

## Usage instructions

To use the script within this repo we assume the following procedures:

1. Download the original data set from the following address: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Unzip the package to a folder (e.g. /data/)
3. Put run_analysis.R into that folder (e.g. /data/)
4. Set the folder as working directory 
5. Upon execution of the script run_analysis.R, the processed data will be export as tidyset.txt in the same folder

