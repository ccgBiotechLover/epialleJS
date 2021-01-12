# epialleJS
Direscription:
A software used for identifying unique epiallele of a sample or common epiallele of two samples through RRBS or WGBS file with sam format and calculating Jensen-Shannon divergence of the epialle of two samples. 

Requirements:
1) Perl with version >=5.0 is required before using epialleJS;
2) The perl module of Getopt::Long should be installed;
3) Linux operating system is prefered;
4) Input file should be the sam file of RRBS or WGBS;

Usage:

1. Appending environment variables of epialleJS to the line "export path=$path:" of the ~/.bash_profile in the user personal directory or switching to the path to epialleJS before runing the software;

2. After switching to the path to epialleJS, command for identifying unique epiallele of a sample is:./unialle -a file1.sam -o outputpath -c coverage -d distance

3. command for identifying common epiallele of two samples is:./epialle -a file1.sam -b file2.sam -o outputpath -c coverage -d distance

Parameter specification:
-a or -b: file of sam format used for identifying epiallele;
-o: output file pathway;
-c: the coverage required for identifying epiallele, default value is 10;
-d: the distance used to set the maximum length of epialleles, default value is 126.

Example:
identification of unique epiallele from test.sam file

cd /path/to/epialle/

./unialle -a ../example_data/test.sam -o ../example_data/

the result file was stored in "test_epialle.txt" file
