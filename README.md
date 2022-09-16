# ocean-carbon-sampling: Can remote sensing features improve estimates of ocean carbon chemistry?

## Usage
This research was conducted for academic purposes
* A high-level synopisis of this work is available in [Google Slides](https://docs.google.com/presentation/d/1HFTMUDnAyxKrMTP1vbWBTwSq39sK34_PUYBl0RD5kGA/)
* Detailed methods are available in [Google Docs](https://docs.google.com/document/d/1YUstJvJRdajhcZSg2fykyrhjAi3K4NUiEEEGszuEIhY/)

Certain utility functions may be useful for future work, including how to download and process NASA MODIS data ([read_modis_color_data](notebooks/read_modis_color_data.ipynb), [read_modis_temp_data](notebooks/read_modis_temp_data.ipynb)), and how to run a series of geospatial sample designs ([sd_rs](notebooks/sd_rs.ipynb), [sd_stratified_rs](notebooks/sd_stratified_rs.ipynb), [sd_doptimal](notebooks/sd_doptimal.ipynb)).

## About
This paper evaluates how remote sensing data can improve estimates of changes in ocean carbon chemistry. I first consider how remote sensing features can help with sampling methods. Specifically, can they improve the selection of locations to take measurements in order to increase the precision of an estimated change in ocean carbon chemistry? Second, I consider how remote sensing data can help predict ocean carbon chemistry, which could yield estimates of changes in ocean carbon chemistry without costly direct measurement. Specifically, I evaluate how much of the variation in this ocean property can be explained by remote sensing features, and I further evaluate how different sampling decisions can increase the explanatory power of the model using remote sensing features.

This study evaluates the viability of remote sensing data at a scale of monthly 4km-resolution data for measuring and predicting pCO2, a single component of the ocean carbon chemistry equilibrium. Future extensions of this work could consider higher resolution data, and more components of the ocean carbon cycle equilibrium (e.g., pH, dissolved inorganic carbon, and alkalinity).

I find that stratified random sample designs using annual remote sensing features make little to no improvement over simple random sample designs that do not rely on remote sensing features. This conclusion might be modified with measurements of changes in pCO2 and the inclusion of ocean current models in a stratification scheme; my conclusions are based on simulated data and do not consider ocean currents. 

I find significant predicting power of monthly 4km-resolution pCO2 by remote sensing features. While a large share of variance in pCO2 cannot be explained by the remote sensing features I consider, these preliminary findings indicate that higher resolution remote sensing data – in both time and space – might help build an effective model for pCO2 predictions, and therefore estimates of changes in the ocean carbon cycle.

## Data
I use remote sensing estimates of sea surface temperature (SST) and chlorophyll a concentrations in this analysis. Both datasets are level 3 products from the MODIS-Aqua sensor, prepared at a 4-kilometer resolution (NASA). In this analysis I use mean monthly images in the date range of  2016-01-01 to 2021-12-31.

I use estimates of the partial pressure of dissolved atmospheric CO2 (pCO2) as a proxy for the ocean carbon cycle. pCO2 is measured in uatm, a unit of pressure, and can be translated into a unit of concentration (e.g., mmole/mole) using gas laws. As mentioned above, a limitation of this study is omitting pH and carbonic acid measurements from my estimates of the carbon cycle. However, pCO2 has been shown to be an an essential component of the ocean carbon cycle and should serve as an adequate representation of the process for this initial evaluation study (Watson).

The first pCO2 data source I used in this analysis is provided by the NOAA Ocean Acidification Data Stewardship (OADS) program, which hosts stationary buoys around the United States that record daily measurements of pH and pCO2 (Sutton). While most of these buoys have recorded one to two years of data, others have recorded more than five. This data requires minimal data cleaning beyond mapping column names across years and datasets, which I did using string-matching. 

[NOAA OADS Mooring Data Viewer](https://www.nodc.noaa.gov/oads/mooringviewer/)

The second pCO2 data source I used in this analysis is provided by the NOAA Ocean Carbon and Acidification Data System (OCADS) project, which hosts a dataset of global surface pCO2 measurements. This dataset includes over 14 million quality-controlled pCO2 measurements recorded over the last 50 years, including 158 cruise routes (Takahashi). This dataset also required very little processing. However, to align this dataset with the remote sensing data described above, I took the average value in each month within the same 4km grid used by MODIS-aqua. 

[NOAA Global Surface pCO2 (LDEO) Database V2019](ncei.noaa.gov/access/ocean-carbon-data-system/oceans/LDEO_Underway_Database/)

## Informing sample selection with remote sensing
To evaluate how remote sensing might improve estimates of changes in ocean carbon chemistry, I first consider sampling methods. In general, sampling methods determine where in a region to measure a property. The locations are selected in such a way that the summary of the measurements can serve as a reliable estimate of the desired property (Cochran). A stratified sampling method subdivides the region of interest into strata that are more homogenous within themselves than across the overall region. Sampling independently within each strata and summarizing estimates of the desired property across strata can increase the precision of the overall estimate (Cochran). 

I evaluate how remote sensing data might be used to stratify sampling regions and improve estimated changes in pCO2. I first identify the remote sensing features most correlated with pCO2. Next, I define sample regions on each of the coasts in the United States (Pacific, Gulf, and Atlantic) and stratify those regions using the identified remote sensing features. Then, I create simple and stratified random sampling designs within these sampling regions, and lastly I compare the precision of the estimated pCO2 from each design using simulated pCO2 data. If remote sensing features can be helpful in stratified sampling designs, I expect increased precision of pCO2 estimates in this scenario. 

### Random sample design
[Random sample designs](results/fig_rs.png)

### Stratified random sample design
[Stratified random sample designs](results/fig_stratified_rs.png)

## Predicting pCO2 with remote sensing
To evaluate how remote sensing might improve estimates of changes in ocean carbon chemistry, I next consider constructing a regression model using remote sensing features to predict changes in pCO2. I first construct an analytical dataset with the finest resolution data available in this study – monthly data at a 4km resolution. This dataset is the same dataset I use in earlier analysis, with the inclusion of monthly sea surface temperature and chlorophyll a values. 

Next, I run a linear regression of all available features on pCO2 to gain insight into the true correlations between remote sensing features and measured pCO2. I also construct a cross-validation framework and use it to evaluate four types of regression models, including Linear Regression, Lasso Regression, Decision Tree Regression, and Random Forest Regression. The goal of this exercise is to preliminarily explore whether other types of regression models may perform better at predicting pCO2. In the cross-validation framework, my metric of interest is the root mean squared error of the predictions on the held-out dataset. In this framework I also ensure that the held-out data is a contiguous sub-region of the ocean, not used for model training, to better simulate out-of-sample predictions.

Lastly, I implement a D-optimal sample design within the sample regions I create in the first part of my analysis. The purpose of this sample design is to illustrate how I might choose sample locations with the goal of minimizing the standard error of the coefficients of a regression model of remote sensing features on pCO2. Technically, D-optimal sample design is a convex optimization problem that seeks to minimize the log-determinant of the variance of all available experiment data, which, in this case, is all available combinations of remote sensing features (Boyd). The optimization problem returns the precise set of available combinations of remote sensing features that should minimize the coefficients of a linear model.

## D-Optimal sample design
[Doptimal sample design](results/fig_doptimal.png)


