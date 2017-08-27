# How script works
## Extracting data 
* Read all files and save them
* Extract only columns with mean and std value

## Cleaning data 
* Give data set labels descriptive name(from features file)
* Give activity(y-column) descriptive name(from activities file)
* Combine all sets together

## Make new data set with mean values
* Grouping_by id and y column
* Creating new data set via summarise_all