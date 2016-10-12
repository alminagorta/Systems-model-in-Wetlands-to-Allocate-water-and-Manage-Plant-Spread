# SWAMPS: [S]ystems model in [W]etlands to [A]llocate water and [M]anage [P]lant [S]pread

We developed a system model to recommend water allocation and invasive vegetation control in wetlands. Recommendations are subject to   constraints such as water availability, spatial connectivity of wetland units, hydraulic infrastructure capacities, plus financial and time resources available to manage invasive vegetation and water. We applied the model at the largest wetland complex at the Great Salt Lake, Utah - [Bear River Migratory Bird Refuge].

[S]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread 
[W]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread 
[A]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread 
[M]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread 
[P]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread 
[S]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread 

[Bear River Migratory Bird Refuge]: http://www.fws.gov/refuge/bear_river_migratory_bird_refuge/


The optimization model was programmed using the General Algebraic Modeling System [GAMS] software. We used Microsoft [Excel] to storage the input data and [Matlab] to post-process and graphically display results.

## Documentation:
This repository presents 4 main folders: 

* [Version1.2_WetlandUnitsAsTanks]: This folder contains the version 1.2 of the optimization model. The input data is a simple Microsoft Excel file ("BRMBR_Input") and the results of the model can be graphically displayed using a Matlab code ("Generation_of-Figures"). This folder also contains the GDX files [Results] that can be used to pass the input and output of the model into different programs.  
* [Version1.5_SpatialWaterDepths]:  This folder contains the version 1.5 of the optimization model. The input data is a simple Microsoft Excel file ("BRMBR_Input") and the results of the model can be graphically displayed using a Matlab code ("Generation_of-Figures"). This folder also contains the GDX files [Results1.5] that can be used to pass the input and output of the model into different programs. 
* [Scripts]: This folder contains the Matlab code used to process the figures on the <a href="http://onlinelibrary.wiley.com/doi/10.1002/2015WR018105/abstract" target="_blank">paper.</a>
* [SupplementaryDocumentation]: This folder contains the Graphical User Interfaces, LiDar data, Habitat Management Plans of the Refuge, previous presentations of the model and a copy of the [paper] submitted to the Water Resources Research Journal.


[GDX]: http://www.gams.com/mccarl/gdxusage



[Version1.2_WetlandUnitsAsTanks]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/1.Version1.2-WetlandUnitsAsTanks

[Version1.5_SpatialWaterDepths]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/2.Version1.5-SpatialWaterDepths

[Scripts]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/3.Scripts_for_Paper

[Results]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/1.Version1.2-WetlandUnitsAsTanks/ResultsV1.2_WetlandUnitsAsTanks

[Results1.5]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/2.Version1.5-SpatialWaterDepths/ResultsV1.5_SpatialDistributionOfWaterDepths

[SupplementaryDocumentation]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/4.SupplementaryDocumentation

### Model Versions:

| Version        | Name          | Post Date  |GUI-Documentation  |
| ------------- |:-------------:| -----:|-----:|
| 1.2     | [Wetland units as a rectangular tanks] | May 2015 |[Workshop instruction] |
| 1.5      | [Wetland units considering the spatial distribution of water depths] |   May 2016 |[Instruction] |

[Workshop instruction]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/blob/master/4.SupplementaryDocumentation/Workshop/SWAMPS-v1.2.WorkshopInstructions.pdf
[Instruction]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/blob/master/4.SupplementaryDocumentation/Workshop/SWAMPS_V1.5-Instructions.pdf
[Wetland units as a rectangular tanks]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/1.Version1.2-WetlandUnitsAsTanks
[Wetland units considering the spatial distribution of water depths]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/2.Version1.5-SpatialWaterDepths

## How to use the model:

Steps to get started:

1. Install the General Algebraic Modeling System ([GAMS]) version 24.1.3 or more recent.
  1. You can download from www.gams.com.
  2. Make sure that your computer has Microsoft [Excel] and [Matlab] (R2013a or more recent)
2. Download the folders contained on this GitHub repository. 
3. Open the GAMS IDE, select File => Project, navigate to the folder [Version1.5_SpatialDistributionOfWaterDepth\MultipleRun], enter a project name and click enter.
4. Select File "SWAMPS_v1.5_MultipleRun_4Scen". This file containts 4 scenarios: (1)Previous Management (Base Case), (2) Automatic Gates, (3) Invasive Vegetation 2X and (4) Invasive Vegetation 3X.
5. Press F9 or run the File in point 4 => GAMS will generate results for the 4 scenarios: (1)ResultSim (Previous Management), (2) ResultOpt (Automatic Gates), (3) ResultCV2 (Invasive Vegetation 2X) and (4) ResultCV3 (Invasive Vegetation 3X).
6. To display graphical results from the GAMS scenario results generated in step 5, open Matlab and change to the folder where the SWAMPS model and results are. Then enter the Matlab Command
>>.Generation_of_Figures3('ResultOpt.xlsx') where ResultOpt.xlsx is the excel file of results generated for the optimization scenario. (Substitute a different excel file for different scenarios)

7. To graphically compare results from 2 or more GAMS scenarios generated in step 5, enter the Matlab Command:
>>.CompareScenarios({'ResultSim' 'ResultOpt'},{'Prior Management' 'Model Recommend'},[1 3])
where ResultSim and ResultOpt are the names of the two GDX files generated for the two optimization runs. See documentation in CompareScenarios.m for further use of the graphing utility.

As a reference, see this <a href="https://www.youtube.com/watch?v=e5REaVgslx8&feature=youtu.be" target="_blank">video</a> about how to start using the SWAMPS model.

[Version1.5_SpatialDistributionOfWaterDepth\MultipleRun]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/2.Version1.5-SpatialWaterDepths/MultipleRun


<a href="https://www.youtube.com/watch?v=e5REaVgslx8&feature=youtu.be
" target="_blank"><img src="http://img.youtube.com/vi/e5REaVgslx8/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>

[GAMS]: http://www.gams.com/
[Excel]: https://products.office.com/en-us/excel
[Matlab]: http://www.mathworks.com/products/matlab/?refresh=true


## Graphical User Interface (GUI):
A [GUI] was developed to facilitate the use of the SWAMPS. Instructions to setup and use the GUI are presented in its respective [documentation]. The GUI allows the user to run a single scenario with input data entered either within the GUI or in an Excel file. Use the Input Type menu to select the model version as either dataAsTank (version 1.2) or dataSpatialWD (version 1.5).

[GUI]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/2.Version1.5-SpatialWaterDepths/GUI_v1.5
[documentation]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/4.SupplementaryDocumentation/Workshop

![alt text] (https://c1c7bcfc-a-98501721-s-sites.googlegroups.com/a/aggiemail.usu.edu/omar-alminagorta-cabezas/Miscel/GUI.png?attachauth=ANoY7coHUNETvNV0hH4qCq1Nl4KqX05s4U0AgblClugZIspBztumCeqkWv3QKpeURYyD_XJwF-z_8e8yEnKnmugeqjbnbQZ8EUWp0K0B7sWVXHHJOkiG6QdYRnRcoq55iqUlm4nP6uTanM-EEdBeU3IDuOT5IM_111E72Pv6FVVEoxU8B-g5_evdQrxDmLuugsNlIGNzXCt97rYpYQoBMoxGgnGIqOg21uvVqEPWzxGyQJQRXPMnhxE%3D&attredirects=0)

## Input and Output of the Model
The model uses a variety of input data to describe the hydrological, ecological, and management components. Model outputs comprise reports, time series, and maps that show water allocations and vegetation control actions among wetland units and how these actions affect the performance in each wetland unit and over time. The table below describes the main inputs and outputs of the model.

   ![alt text](https://c1c7bcfc-a-98501721-s-sites.googlegroups.com/a/aggiemail.usu.edu/omar-alminagorta-cabezas/Miscel/Input_Outputs.png?attachauth=ANoY7cr2gFwb7DInLFJnBZEIWJB3Wg5qIz2I_9nBYZfDz7w04NL31ifLVeu4TzimatuV8ycs-FJPMHzWZKGrQF8xhOMSUExTl7ynxneJL62M3cNOGW4Nkjk-23UJOYWD5mMEvBJjOlMuZlgkmF8rSOYONRV25ZfDh4KBOB4TMX4OspjRBz2d6LR8R69nQqR81C50C3cq96tmkt47FLXJLvV5U7_pKmORp0EpyDKuhvRheMYU9hMYwf7fBOMu9v6aD4jXyqlmY2Wy&attredirects=0 "Logo Title Text 1")
 

### Alternative Scenarios:
The model can perform different scenarios such as:
* **Changes in invasive vegetation response**: Model allows estimating the natural expansions of invasive vegetation cover over time. To modify the invasive vegetation response:
  * Open the Excel file from the [SystemModel] folder and input the percentage of invasive vegetation response into the _vegRes_ sheet.Save the Excel input file and then run the [GAMS code].
* **Changes in invasive vegetation cover**: User can adjust the initial vegetation cover. To modify the initial vegetation cover :
  * In the Excel file from the [SystemModel] folder modify the parameters _Init_CV_. Then run the GAMS code.
* **Changes in budget to reduce invasive vegetation**: User can adjust the financial budget (parameter budget) to represent an increase and decrease in the budget to remove invasive vegetation.To modify the budget:
  * In the Excel file from the [SystemModel] folder, modify the parameter _budget_. Then run the GAMS code.
* **Changes in water availability**: Model allows user to identified the impact of extreme hydrological events on wetland performance. To modify the inflow :
  * In the Excel file from the [SystemModel] folder, input the discharge data in the _Inflow_ sheet. Then run the GAMS code.
* **Simulation**: Wetland managers can also use the simulation capabilities to allocate pre-determined volumes of water to particular wetland units to achieve goals such as provide specific water depths in wetland units to provide recreation (hunting) services or control avian diseases like botulism. To modify the invasive vegetation response:
  * Open the GAMS model from the [SystemModel] folder and activate the Equation _S.fx(yr,mn,dy,wu)= DemandHy(yr,mn,dy,wu)_ in the GAMS code. Save it and then run the GAMS code.

For more information, follow further instructions in the [Excel input file]. 

[Excel input file]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/blob/master/1.Version1.2-WetlandUnitsAsTanks/Model_v1.2/BRMBR_Input.xls
[Bear River Migratory Bird Refuge]: http://www.fws.gov/refuge/bear_river_migratory_bird_refuge/

[GAMS]: http://www.gams.com/

## Publication and Presentations:
The paper was published in the Water Resources Research Journal. More information available in the <a href="https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/4.SupplementaryDocumentation/ManuscriptDrafts" target="_blank">[paper]</a>, previous [presentation] and [poster].

[presentation]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/blob/master/4.SupplementaryDocumentation/Presentations/SpringRunoffConference_2013.pdf
[poster]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/blob/master/4.SupplementaryDocumentation/Presentations/AGU_Poster_Dec2012.pdf

[paper]: http://onlinelibrary.wiley.com/doi/10.1002/2015WR018105/abstract

## Future work:
Future work should identify dynamic vegetation responses to water levels through time, extend the wetland performance metric to consider additional abiotic and biotic factors that affect animal habitat, and consider alternative ways to mathematically aggregate habitat suitability indices.  Also,  The current model considers a time period of one year. Further system analysis should focus on extending the time  period  analysis  to  multi-year.  This  extension  will  provide  a  better understanding  of  how  water  allocation  affects  invasive  Phragmites  during  its complete life period. 

## Licensing:
Materials in this GitHub repository are disturbed under a [BSD 3-Clause license]. For alternative licensing arrangements, contact Omar Alminagorta and David E. Rosenberg directly. 

[BSD 3-Clause license]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/blob/master/LICENSE

## Citation:
Alminagorta, O., D. E. Rosenberg, and K. M. Kettenring (2016), Systems modeling to improve the hydro-ecological performance of diked wetlands, Water Resour. Res., 52, [doi:10.1002/2015WR018105].

[doi:10.1002/2015WR018105]: http://onlinelibrary.wiley.com/doi/10.1002/2015WR018105/full

## Authors :
* [Omar Alminagorta], Former postdoctoral Associate at the Utah Water Research Laboratory, Utah State University, Logan, UT, o.alminagorta@aggiemail.usu.edu
* [David E. Rosenberg], Associate Professor, Department of  Civil and Environmental Engineering and Utah Water Research Laboratory, Utah State University, Logan, UT, david.rosenberg@usu.edu
* [Karin M. Kettenring], Associate Professor, Ecology Center and Department of Watershed Sciences, Utah State University, Logan, UT, karin.kettenring@usu.edu
[Omar Alminagorta]: https://sites.google.com/a/aggiemail.usu.edu/omar-alminagorta-cabezas/
[David E. Rosenberg]:http://www.engr.usu.edu/cee/faculty/derosenberg/
[Karin M. Kettenring]: http://www.cnr.usu.edu/htm/facstaff/Kettenring

## In the News 

[ScienceDaily] and [NaturalScienceNews]

[ScienceDaily]: https://www.sciencedaily.com/releases/2016/09/160902105843.htm
[NaturalScienceNews]: http://naturalsciencenews.com/2016/09/03/researchers-develop-mathematical-model-for-managing-wetlands/



## Model Application at the Refuge:
We applied the model at the Bear River Migratory Bird Refuge, which is the largest wetland complex on the Great Salt Lake, Utah. The Refuge includes [25 managed wetland units] separated by dikes and supplied water through a series of canals controlled by gates and weirs. This hydraulic infrastructure allows managers to manipulate water levels in each wetland unit with the main purpose to provide habitat for a wide variety of plants, insects, amphibians, and birds. The Refuge typically experiences hydrological and ecological changes over time (e.g., water scarcity, invasive vegetation). Thus, Refuge managers have a pressing need to better allocate scarce water and control invasive vegetation to promote diverse habitat types and support a variety of bird species.
SWAMPS can provide to wetland manager an alternative tool to measure wetland performance as well as understand how wetland performance is affected by flow variability or invasive vegetation cover. 

## More information about the Refuge 
* <a href="http://www.fws.gov/refuge/bear_river_migratory_bird_refuge/" target="_blank">The Refuge Web</a>
* <a href="http://brmbr.weebly.com/" target="_blank">Spatial and Hydrological information</a>
* Hydrological and ecological changes over time (video below)

<a href="http://www.youtube.com/watch?feature=player_embedded&v=ZiqBfp_Bl74
" target="_blank"><img src="http://img.youtube.com/vi/ZiqBfp_Bl74/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>

[25 managed wetland units]:http://www.oalminagorta.cu.cc/WetlandUnitsMap.html





