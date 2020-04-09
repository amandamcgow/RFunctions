# RFunctions
R Functions that I use and find helpful for analysis as well as graphing data.

## Getting Started
You will need to install packages including but not limited to ggplot, Hmisc, readr, Rmisc, and doBy. 

You can download the folders for the function you would like to use. Each folder contains sample data, R markdown file, and PDF output for any figures created. The PDF can be loaded into Adobe Illustrator and edited as a vector illustration.

AllFunctions is an R markdown file containing the code to all functions.

## Functions List 

* **Chi-Square**: Computes Chi-Square. Examples with Yates' correction and without Yates' correction are provided.
       
       ```r
       RaceChi <- matrix(c(nrow(temp1), nrow(temp2), nrow(temp3), nrow(temp4)),
              nrow = 2,
              dimnames = list("Race" = c("White", "Nonwhite"),
                              "Group" = c("LowFit", "HighFit")))

       # use Yates' correction when at least one cell of table has count < 5
       chisq.test(RaceChi)    
       
       # remove Yates' correction
       chisq.test(RaceChi, correct = FALSE)

       # remove scientific notation
       options(scipen=999)
       ```
* **Bar Graph**: Creates bar graph and saves to PDF that can be imported into Adobe Illustrator as a vector illustration for editing. Image shown is not yet edited in Adobe Illustrator, so does not look perfect.

       ![] (images/BarGraph.png)
