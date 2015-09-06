# SWAMPS: [S]ystems model in [W]etlands to [A]llocate water and [M]anage [P]lant [S]pread

We developed a system model to quantify the hydro-ecological performance of diked wetlands and embed this performance into an optimization model to recommend water allocation and invasive vegetation control in wetlands. First, we measure the hydro-ecological performance for wetlands using the habitat suitability approach. Second, we subject model recommendations for water allocations and invasive plant management in wetlands to constraints like water availability, spatial connectivity of wetland units, hydraulic infrastructure capacities, plus financial and time resources available to manage invasive vegetation and water. Third, we applied the model at the [Bear River Migratory Bird Refuge], which is the largest wetland complex on the Great Salt Lake, Utah.
The approach demonstrates a framework to develop and apply hydro-ecological performance metrics for wetlands, embed those metrics into an optimization model, and recommend management strategies to improve wetland performance. 

[S]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread 
[W]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread 
[A]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread 
[M]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread 
[P]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread 
[S]:https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread 

[Bear River Migratory Bird Refuge]: http://www.fws.gov/refuge/bear_river_migratory_bird_refuge/



## Input and Output of the Model
The model uses a variety of input data to describe the hydrological, ecological, and management components. Model outputs comprise reports, time series, and maps that show water allocations and vegetation control actions among wetland units and how these actions affect the performance in each wetland unit and over time. The table below describes the main inputs and outputs of the model.

   ![alt text](https://c1c7bcfc-a-98501721-s-sites.googlegroups.com/a/aggiemail.usu.edu/omar-alminagorta-cabezas/Miscel/Input_Outputs.png?attachauth=ANoY7cr2gFwb7DInLFJnBZEIWJB3Wg5qIz2I_9nBYZfDz7w04NL31ifLVeu4TzimatuV8ycs-FJPMHzWZKGrQF8xhOMSUExTl7ynxneJL62M3cNOGW4Nkjk-23UJOYWD5mMEvBJjOlMuZlgkmF8rSOYONRV25ZfDh4KBOB4TMX4OspjRBz2d6LR8R69nQqR81C50C3cq96tmkt47FLXJLvV5U7_pKmORp0EpyDKuhvRheMYU9hMYwf7fBOMu9v6aD4jXyqlmY2Wy&attredirects=0 "Logo Title Text 1")


The optimization model was programmed using the General Algebraic Modeling System [GAMS] software. We used Microsoft [Excel] to storage the input data and [Matlab] to post-process and graphically display results.

## Documentation:
This repository presents 4 main folders: 

* [SystemModel]:This folder contains the optimization model developed in [GAMS], the input data in a simple Microsoft Excel file ("BRMBR_Input") and a Matlab code ("Generation_of-Figures") to graphically display results of the model.
* [Scripts_for_Paper]: This folder contains the Matlab code used to process the figures on the paper.
* [GDX_files]: This folder contains [GDX] files that can be used to pass the input and output of the model into different programs.  
* [SupplementaryDocumentation]: This folder contains the LiDar data and Habitat Management Plans of the Refuge.


[GDX]: http://www.gams.com/mccarl/gdxusage



[SystemModel]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/1.SystemModel

[Scripts_for_Paper]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/2.Scripts_for_Paper

[GDX_files]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/3.GDX_files

[SupplementaryDocumentation]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/tree/master/4.SupplementaryDocumentation



## How to use the model:

Steps to get started:

1. Install the General Algebraic Modeling System ([GAMS]) version 24.1.3 or more recent.
  1. You can download from www.gams.com.
  2. Make sure that your computer has Microsoft [Excel] and [Matlab] (R2013a or more recent)
2. Download the folders contained on this GitHub repository. 
3. Open the [GAMS code] in the folder [SystemModel] and run the model
4. The GAMS script will generate a report with the model outputs. To display graphical results from the GAMS code, run the Matlab code "Generation_of_Figures"

For more details, see this [video] about how to start using the SWAMPS model.

[GAMS]: http://www.gams.com/
[Excel]: https://products.office.com/en-us/excel
[Matlab]: http://www.mathworks.com/products/matlab/?refresh=true
[video]: https://www.youtube.com/watch?v=e5REaVgslx8&feature=youtu.be

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
  * Open the GAMS model from the [SystemModel] folder and activate the Equation _S.fx(yr,mn,dy,wu)= DemandHy(yr,mn,dy,wu)_ in the [GAMS code]. Save it and then run the GAMS code.

For more information, follow further instructions in the [Excel input file]. 

[Excel input file]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/blob/master/1.SystemModel/BRMBR_Input.xls

[Bear River Migratory Bird Refuge]: http://www.fws.gov/refuge/bear_river_migratory_bird_refuge/

[GAMS]: http://www.gams.com/
[GAMS code]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/blob/master/1.SystemModel/SWAMPS_model_GAMS_code_v1.2.gms

## Publication and Presentations:
Paper in revision to resubmit to Water Resources Research Journal. A preliminary description of the model can be founded in previous [presentation], [poster] or in the third Chapter of my [Thesis] 

[Thesis]: http://digitalcommons.usu.edu/etd/4375/
[presentation]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/blob/master/4.SupplementaryDocumentation/Presentations/SpringRunoffConference_2013.pdf
[poster]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/blob/master/4.SupplementaryDocumentation/Presentations/AGU_Poster_Dec2012.pdf


## Future work:
Future work should identify dynamic vegetation responses to water levels through time, extend the wetland performance metric to consider additional abiotic and biotic factors that affect animal habitat, and consider alternative ways to mathematically aggregate habitat suitability indices.  Also,  The current model considers a time period of one year. Further system analysis should focus on extending the time  period  analysis  to  multi-year.  This  extension  will  provide  a  better understanding  of  how  water  allocation  affects  invasive  Phragmites  during  its complete life period. 

## Licensing:
Materials in this GitHub repository are disturbed under a [BSD 3-Clause license]. For alternative licensing arrangements, contact Omar Alminagorta and David E. Rosenberg directly. 

[BSD 3-Clause license]: https://github.com/alminagorta/Systems-model-in-Wetlands-to-Allocate-water-and-Manage-Plant-Spread/edit/master/LICENSE

## Citation:
Alminagorta, O., D. E. Rosenberg, and K. M. Kettenring, Systems modeling to improve  the  hydro-ecological  performance  of diked  wetlands, (Under Review to resubmit to Water Resources Research Journal).
## Authors :
* [Omar Alminagorta], Postdoctoral Associate at the Utah Water Research Laboratory, Utah State University, Logan, UT, o.alminagorta@aggiemail.usu.edu
* [David E. Rosenberg], Associate Professor, Department of  Civil and Environmental Engineering and Utah Water Research Laboratory, Utah State University, Logan, UT, david.rosenberg@usu.edu
* [Karin M. Kettenring], Associate Professor, Ecology Center and Department of Watershed Sciences, Utah State University, Logan, UT, karin.kettenring@usu.edu
[Omar Alminagorta]: https://sites.google.com/a/aggiemail.usu.edu/omar-alminagorta-cabezas/
[David E. Rosenberg]:http://www.engr.usu.edu/cee/faculty/derosenberg/
[Karin M. Kettenring]: http://www.cnr.usu.edu/htm/facstaff/Kettenring

## Model Application at the Refuge:
We applied the model at the Bear River Migratory Bird Refuge, which is the largest wetland complex on the Great Salt Lake, Utah. The Refuge includes 25 managed wetland units separated by dikes and supplied water through a series of canals controlled by gates and weirs. This hydraulic infrastructure allows managers to manipulate water levels in each wetland unit with the main purpose to provide habitat for a wide variety of plants, insects, amphibians, and birds. The Refuge typically experiences hydrological and ecological changes over time (e.g., water scarcity, invasive vegetation). Thus, Refuge managers have a pressing need to better allocate scarce water and control invasive vegetation to promote diverse habitat types and support a variety of bird species.
SWAMPS can provide to wetland manager an alternative tool to measure wetland performance as well as understand how wetland performance is affected by flow variability or invasive vegetation cover. 

## More about the Refuge
* [The Refuge Web](http://www.fws.gov/refuge/bear_river_migratory_bird_refuge/)
* [Spatial and Hydrological information](http://brmbr.weebly.com/)
* Hydrological and ecological changes over time 

<a href="http://www.youtube.com/watch?feature=player_embedded&v=ZiqBfp_Bl74
" target="_blank"><img src="http://img.youtube.com/vi/ZiqBfp_Bl74/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>

[25 managed wetland units]:http://www.oalminagorta.cu.cc/WetlandUnitsMap.html





