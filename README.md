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

![](images/BarGraph.png)

* **Correlation Plot**: Creates correlation plot and saves to PDF that can be imported into Adobe Illustrator as a vector illustration for editing. Image shown is not yet edited in Adobe Illustrator, so does not look perfect.

![](images/CorrelationPlot.png)

* **ERP Waveform Plot**: Creates plot for ERP waveform and saves to PDF that can be imported into Adobe Illustrator as a vector illustration for editing. Image shown is not yet edited in Adobe Illustrator, so does not look perfect.

![](images/ERPWaveform.png)

* **ERP Waveform Plot with Smoothing**: Creates plot for ERP waveforms with smoothing and saves to PDF that can be imported into Adobe Illustrator as a vector illustration for editing. Image shown is not yet edited in Adobe Illustrator, so does not look perfect.

![](images/ERPWaveform_Smoothed.png)

* **Line Graph for Pre Post Designs**: Creates plot for pre/post designs and saves to PDF that can be imported into Adobe Illustrator as a vector illustration for editing. Image shown is not yet edited in Adobe Illustrator, so does not look perfect.

![](images/LineGraphPrePost.png)

* **Line Graph for Longitudinal Designs**: Creates plot for longitudinal designs with custom spacing for x-axis and saves to PDF that can be imported into Adobe Illustrator as a vector illustration for editing. Image shown is not yet edited in Adobe Illustrator, so does not look perfect.

![](images/LongitudinalLineGraph.png)

* **Pupil Waveform Plot**: Creates plot for pupil waveforms and saves to PDF that can be imported into Adobe Illustrator as a vector illustration for editing. Image shown is not yet edited in Adobe Illustrator, so does not look perfect.

![](images/PupilWaveform.png)

* **Scatterplot**: Creates scatterplot and saves to PDF that can be imported into Adobe Illustrator as a vector illustration for editing. Image shown is not yet edited in Adobe Illustrator, so does not look perfect.

![](images/Scatterplot.png)

* **IndividualPlots**: Creates scatterplot of time series data for each participant with lm regression line and saves each to a page in the same PDF. Helpful for exploratory graphing to determine appropriateness for growth modeling. Image shown is not yet edited in Adobe Illustrator, so does not look perfect (only shows one page, which is one participant).

![](images/IndividualPlots.png)

* **GrowthCurve**: Plot of growth curve model fit in nlme. Can add dashed line and points depciting actual values to compare to model fit.

![](images/GrowthCurve.png)

* **PersonSpecificNetworks**: Makes use of the plot_network_graph function from pompom package in R and same function in qgraph. However, the function can be edited to change aesthetics of the graph (e.g., line color, shape of nodes, etc.). Code to save the graph to a PDF to edit in Illustrator is also provided. Green lines depict positive relationships, red lines depict negative relationships, solid lines represent contemporaneous relationships (same-day), and dashed lines represent lagged (t-1) relationships.

![](images/PersonSpecificNetworks.png)
