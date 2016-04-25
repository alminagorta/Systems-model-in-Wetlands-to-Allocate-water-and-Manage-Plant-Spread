$TITLE: SWAMPS v1.5 : Systems model in Wetlands to Allocate water and Manage Plant Spread

$Ontext

Created by Omar Alminagorta, David E. Rosenberg
Utah Water Research Laboratory, Utah State University.
Updated March 2016 - Version 1.5 (Merge of Matlab GUI and Excel
     input versions into a single file)

The model recommends water allocation and invasive vegetation removal to improve the wetland performance
Model is applied to 25 wetland units at the Bear River Migratory Bird Refuge.

-------------------------------------------------------------------------------
How to use it:

Input: The model uses the excel file "BRMBR_Input" and optionally
       data specied in Matlab GUI to input data
Output: After run the GAMS code, the model will generate a report results and a GDX file ("Result.gdx").
       To graphically display results we can also use the matlab file "Generation_of_Figures"

Use Scalar DataSource to control source of model input data. Options are:
  1 = entirely from Excel file "BRMBR_Input.xls"
  2 = Vegetation Response, Budget, Species Weight, and Initial Storage in Wetland Units

Use Scalar ModelType to specify the type of model to run. Options are:
  1 = Run in simulation model. Adds equations:
             S.fx(yr,mn,dy,wu)= DemandHy(yr,mn,dy,wu)
  2 = Run in optimization mode (no gate constraints; solves Model Nov2015)
  3 = Run in optimization mode with gate constraints. Sovles Model GateConstraint

+++++++++++++++++++++++++=   Updated  10 April -2016
I just added:
- a set to simulate multiple veget cover "ivc"
- a parameter "InitIVCMult"
- multiple runs (at the end)

++++++++++++

This version can use the Matlab GUI executable without need of MATLAB license, but still needs GAMS license
See more information in the Instruction document.
-------------------------------------------------------------------------------
If you use the model or part of the code, cite as:

Alminagorta, O., D. E. Rosenberg, and K. M. Kettenring, Systems modeling to improve  the  hydro-ecological  performance  of
diked  wetlands, (in review at the Water Resources Research Journal).
-------------------------------------------------------------------------------

Licensing:

Copyright (c) 2015, Omar Alminagorta and David E. Rosenberg
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

$Offtext

*===================================
* Input Data
*===================================

SETS     i        all model nodes
         spec     number of bird species for Cover Vegetation and for Hydrologic Condition
         dem      Demand of water
         yr       year
         mn       month
         dy       day
         jn(i)    Subsets for junctions
         wu(i)    Subsets for wetland units
         Out(i)   Subsets for Outlets

         ivc      invasive vegetation factor to run scenarios /ivc1*ivc3/
 ;

Alias(i,j)

Sets
        jn_ts_par /
Inflow
/
        wu_par_par /
MaxStor
MinStor
TotalArea

MaxDepth
Demand
/
        wu_ts_par /
Inflow
InitialStor
InitCViv
LossEvap
/
        link_par_par /
LossQ
MaxQ
MinQ

/
        Out_par_par /
MaxQu
MinQu
LossQu

/
        CVeget /
CV2

/


        Water/
Vol
Area
WD
Sp1
WUAWsp
/

         Paramet/
a
b
c
d
e
f
a2
b2
c2
/

         type /
Typ1
Typ2
Typ3
/



*=================================================
*To import data from excel
*=================================================

$CALL GDXXRW.EXE BRMBR_Input.xls Set=i rng=nodes!A1:A500 Rdim=1  Set=spec rng=BirdSpec!A1:A500 Rdim=1  Set=yr rng=yr!A1:A500 Rdim=1   Set=mn rng=mn!A1:A500 Rdim=1   Set=dy rng=dy!A1:A500 Rdim=1   set=jn rng=junction!A1:A500 Rdim=1  set=wu rng=wu!A1:A500 Rdim=1   set=Out rng=Out!A1:A500 Rdim=1  set=links rng=links!A1:B500 Rdim=2  par=jn_ts_data  rng=Inflow!A1 Rdim=3 Cdim=2    par=wu_ts_data  rng=Table!A1 Rdim=3 Cdim=2   par=Out_par_data  rng=out_data!A1 Rdim=1 Cdim=1   par=wu_par_data  rng=wu_data!A1 Rdim=1 Cdim=1    par= link_par_data  rng=link_data!A1  Rdim=2 Cdim=1     par=Connect  rng=link!A1  Rdim=1 Cdim=1    par=LossEvapo rng=evap!A1 Rdim=1     Set=dem rng=demStor!A1 Rdim=1   par=DemandStor rng=Demd!A1   Rdim=4 Cdim=1   par=ParametCurve   rng=Param!A1 Rdim=2 Cdim=1    par=UnitMang rng=Um!A1 Rdim=2 Cdim=1   par=VegMag rng=vegm!A1 Rdim=1    par=UnitCost rng=unitc!A1 Rdim=1    par=VegResp rng=vegRes!A1 Rdim=1   par=AvalGateAct rng=avalGate!A1 Rdim=1   par=B rng=budget!A1 Rdim=0   par=specweight rng=specWeight!A1 Rdim=1 Cdim=1   par=PHW1 rng=Param_HW!B2 Rdim=0   par=PHW2 rng=Param_HW!C2 Rdim=0   par=PHW3 rng=Param_HW!D2 Rdim=0   par=PHW4 rng=Param_HW!E2 Rdim=0   par=PHW5 rng=Param_HW!F2 Rdim=0   par=PHW6 rng=Param_HW!G2 Rdim=0   par=PHW7 rng=Param_HW!H2 Rdim=0   par=PHV1 rng=Param_HV!B2 Rdim=0   par=PHV2 rng=Param_HV!C2 Rdim=0   par=PHV3 rng=Param_HV!D2 Rdim=0   par=PHV4 rng=Param_HV!E2 Rdim=0   par=wu_ts_data2  rng=Init_CV!A1 Rdim=1 Cdim=1  par=wu_ts_data3  rng=Init_Stor!A1 Rdim=1 Cdim=1

SET links(i,j)  link from i to j ;
Parameter jn_ts_data(yr,mn,dy,jn_ts_par,jn) ;
Parameter wu_ts_data(yr,mn,dy,wu_ts_par,wu) ;
Parameter wu_ts_data2(wu,wu_ts_par) ;
Parameter wu_ts_data3(wu,wu_ts_par) ;
Parameter Out_par_data(Out,Out_par_par);
Parameter wu_par_data(wu,wu_par_par);
Parameter link_par_data(i,j,link_par_par) ;
Parameter Connect(i,j);
Parameter LossEvapo(mn);
Parameter DemandStor(yr,mn,dy,wu,dem) ;
Parameter ParametCurve(wu,mn,Paramet);
Parameter UnitMang (wu,mn,spec);

Parameter VegMag(mn);
Parameter UnitCost(mn);
Parameter VegResp(mn);
Parameter AvalGateAct(mn);
Scalar B;
Parameter specweight(mn,spec);
*Parameters to generate Suitability Curve related to Wdepth preferences
Scalar PHW1;
Scalar PHW2;
Scalar PHW3;
Scalar PHW4;
Scalar PHW5;
Scalar PHW6;
Scalar PHW7;
*Parameters to generate Suitability Curve related to invasive vegetation removal
Scalar PHV1;
Scalar PHV2;
Scalar PHV3;
Scalar PHV4;
*Parameters to generate depth-weighted HSI area curves (area as a function of staff gage height)
Set pars Parameters for fitted functions;
Parameter DWparams(wu,spec,pars) Depth-Weighted HSI Area function parameters

$GDXIN BRMBR_Input.gdx
$LOAD   i
$LOAD   spec
$LOAD   yr
$LOAD   mn
$LOAD   dy
$LOAD   jn
$LOAD   wu
$LOAD   Out
$LOAD   links
$LOAD   jn_ts_data
$LOAD   wu_ts_data
$LOAD   Out_par_data
$LOAD   wu_par_data
$LOAD   link_par_data
$LOAD   Connect
$LOAD   LossEvapo
$LOAD   dem
$LOAD   DemandStor
$LOAD   ParametCurve
$LOAD   UnitMang
$LOAD   VegMag
$LOAD   UnitCost

$LOAD   AvalGateAct
*MMMMMMMMMM
*Initially load input data from Excel file
$LOAD   B
$LOAD   specweight
$LOAD   VegResp

$LOAD   PHW1
$LOAD   PHW2
$LOAD   PHW3
$LOAD   PHW4
$LOAD   PHW5
$LOAD   PHW6
$LOAD   PHW7

$LOAD   PHV1
$LOAD   PHV2
$LOAD   PHV3
$LOAD   PHV4
$LOAD    wu_ts_data2
$LOAD    wu_ts_data3

$GDXIN

$GDXIN G_DWparams.gdx
$LOAD   pars
$LOAD   DWparams

$GDXIN

DISPLAY DWparams;

*===================================
* further subsets to simplify model
*===================================


Sets
         stor(i) storage node (wetland units)
         nonstor(i) non storage nodes (e.g. junctions.)    ;

         stor(i) = wu(i);
         nonstor(i) = not stor(i);

*-------------------------------------------------------------------------------
* Defining parameters aggregating from different subsets to simplify the model
*-------------------------------------------------------------------------------


Parameter Inflow(yr,mn,dy,i) inflow   ;
          Inflow(yr,mn,dy,wu) =  WU_ts_data(yr,mn,dy,"Inflow",wu) ;
          Inflow(yr,mn,dy,jn) =  JN_ts_data(yr,mn,dy,"Inflow",jn) ;

*MMMMMMMMMM
         Parameter initStor2(i) initial storage at wetland ha-m) ;
          initStor2(wu) =  wu_ts_data3(wu,"InitialStor")  ;

Parameter lossQ(i,j)  link shows the loss in channels ;
          lossQ(i,j) = link_par_data(i,j,"lossQ") ;

Parameter MaxQ(i,j) parameter with all max flows ;
          MaxQ(i,j) = link_par_data(i,j,"MaxQ") ;

Parameter MinQ(i,j) parameter with all min flows ;
          MinQ(i,j) = link_par_data(i,j,"MinQ") ;

Parameter MaxStor(i) parameter with max storage levels of all storage nodes ;
          MaxStor(wu) = WU_par_data(wu,"MaxStor") ;

Parameter MinStor(i) parameter with min storage levels of all storage nodes ;
          MinStor(wu) = WU_par_data(wu,"MinStor") ;

Parameter MaxDepth (i) parameter with max storage levels of all storage nodes ;
          MaxDepth (wu) = WU_par_data(wu,"MaxDepth") ;

Parameter TotalArea (i) parameter with max storage levels of all storage nodes ;
          TotalArea (wu) = WU_par_data(wu,"TotalArea") ;

*At the outlet
Parameter MaxOut(i) parameter with max flow at the outflow  ;
          MaxOut(Out) = Out_par_data(Out,"MaxQu") ;

Parameter MinOut(i) parameter with max flow at the outflow  ;
          MinOut(Out) = Out_par_data(Out,"MinQu") ;


Parameter InitCV_iv2(i) initial coverage vegetation (%)  ;
          InitCV_iv2(wu) =  wu_ts_data2(wu,"InitCViv") ;


Parameter DemandHy(yr,mn,dy,wu)  ;
          DemandHy(yr,mn,dy,wu) =  DemandStor(yr,mn,dy,wu,"Demand")    ;


Parameter InitValuesStorage(yr,mn,dy,wu)  ;
          InitValuesStorage(yr,mn,dy,wu) =  DemandStor(yr,mn,dy,wu,"InitValuesStor");

*Parameters to define the relationship Wdepth-Storage and Flood Area [Based on Lidar data]
Parameter AA(wu,mn) first parameter lineal Eq. to estimate Wdepth;
          AA(wu,mn) = ParametCurve (wu,mn,"a") ;

Parameter BB(wu,mn) second parameter lineal Eq.  to estimate Wdepth;
          BB(wu,mn) = ParametCurve (wu,mn,"b") ;

Parameter FF(wu,mn) second parameter lineal Eq.  to estimate Wdepth;
          FF(wu,mn) = ParametCurve (wu,mn,"f") ;

Parameter CC(wu,mn) first parameter Quadratic Eq. to estimate Area;
          CC(wu,mn) = ParametCurve (wu,mn,"c") ;

Parameter DD(wu,mn) second parameter Quadratic Eq. to estimate Area;
          DD(wu,mn) = ParametCurve (wu,mn,"d") ;

Parameter EE(wu,mn) third parameter Quadratic Eq. to estimate Area;
          EE(wu,mn) = ParametCurve (wu,mn,"e") ;


*To evaluate multscen
Parameter InitIVCMult(ivc) Initial invasive vegetation cover as a multiple of base case
      /ivc1 0, ivc2 2, ivc3 3/;


*type of model to solve
*1=Using GUI data and running simulation
*2=Using GUI data and running Optimization
*3=Using GUI data and running Gate constrained

Parameter ModelType, DataSource Flag for source of data /1/;

*OA-Use for GUI 9Ap16
*^$GDXIN G_ModelType
*^$LOAD ModelType
*$LOAD DataSource
*^$GDXIN

$ontext
*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
*==========================================
* Read select inputs from Matlab interface into temporary parameters
* ==========================================

Parameters B_gui,VegResp_gui(mn),specweight_gui(mn,spec),initStor2_gui(wu);

*   ++++++Ecological Inputs from Matlab++++++++++++
*    Parameter B ;
$GDXIN G_Budget
$LOAD B_gui
$GDXIN

*   This is for parameters of VegetResponse
*    Parameter VegResp(mn) ;
$GDXIN G_VegResponse
$LOAD VegResp_gui
$GDXIN
*   This is for SpeciesWeight,
*    Parameter specweight(mn,spec) ;
$GDXIN G_specweight
$LOAD specweight_gui
$GDXIN

*   This is for Initial Storage,
*    Parameter initStor2(wu);
$GDXIN G_initStor
$LOAD initStor2
$GDXIN

if (DataSource eq 2,
*   Copy temporary parameters into model parameters
    B = B_gui;
    VegResp(mn) = VegResp_gui(mn);
    specweight(mn,spec) = specweight_gui(mn,spec);
    initStor2(wu) = initStor2_gui(wu);
    );
*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
$offtext
*==========================================
* Generation of Variables and Equations
*==========================================
VARIABLES

*Variables related with mass balance
      Q (yr,mn,dy,i,j)              Volume of flow from node i to j during period yr-mn-dy  -(Ha-m per month)
      S  (yr,mn,dy,i)               Storage wetland units(Ha-m)
      delivery(yr,mn,dy,i)          Delivery into each wetland unit ( Ha-m)
      R  (yr,mn,dy,i)               Releases from node upstream (Ha-m)
      Evapo(yr,mn,dy,wu)           Evaporation (m3 per month)
*Variables related with Habitat and Cover Vegetation
      CVinvasive(yr,mn,dy,i)       Cover for Invasive Vegetation at wetlad unit(%)
      RemovedCV(yr,mn,dy,i)        Invasive Cover Vegetation that is removed  (%)
*     ROW_CV(yr,mn,dy,i,p)         Interpolation row for Cover Vegetation
      HSI_CVinv(yr,mn,dy,i)        Habitat Suitability Index for Invasive Vegetation
      Bud(yr,mn,dy,wu)             Total Quantity of Money per Management in Wetland ($)

*Variables related with Habitat and Water
      Area(yr,mn,dy,i)             Flood Area (m2)
      WDepth(yr,mn,dy,i)           Water depth founded based on the Storage
      HSI_spec(yr,mn,dy,i,spec)    Habitat Suitability Index for Hydrologic condition and per species
      HSI_compWD(yr,mn,dy,i)       HSI related to hydrological condition considering diferents weight of species

*%%%For gates%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     GateAct (yr,mn,dy)           Gates Accion - G close to 1 means open&G close to zero means close
     GateActRelease(yr,mn,dy,wu)   Gates related with Release
     GateActDeliv(yr,mn,dy,wu)     Gates related with Delivery
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


***    HSI_UnitManag(yr,mn,dy,wu,spec)
*Compilation
      HSIcomp(yr,mn,dy,i)      Combining both HSI hydrological and CVegetation(adimensional)
      WUAW(yr,mn,dy,i)         Weight Usable Area for Wetland and by species (m2)  estimated with analytical functions
*      WUAW2(yr,mn,dy,i)       Weight Usable Area for Wetland and by species (m2)  estimated with interpolation
      Obj                      Objective Function (m2)

***   Variables for depth-weighted HSI area method
      DVS(yr,mn,dy,wu,spec)     Depth varying suitable area for wetland unit stor and species spec (m2)



POSITIVE VARIABLES
     Q,
S,
RemovedCV
,CVinvasive
,R
*HSI_spec
,Area,
DWA
;


EQUATIONS

*Eq related with mass balance
     EqMassBalNonStor(yr,mn,dy,i)  Mass Balance at nonstorage nodes
     EqMassBalNonStor_Out(yr,mn,dy,Out)  Outflow to the Great Salt Lake
     EqMassBal_WU(yr,mn,dy,i)      Mass Balance at wetland units
     EqMaxQ(yr,mn,dy,i,j)          Maximun flow at canals
     EqMinQ(yr,mn,dy,i,j)          Minimun flow at canals
     EqMaxStor(yr,mn,dy,i)         Maximun storage at wetland units
     EqMinStor(yr,mn,dy,i)         Minimun storage at wetland units
     EqEvap(yr,mn,dy,wu)           Estimation of Evaporation
     EqDelivery(yr,mn,dy,i)
     EqRelease(yr,mn,dy,i)
*Eq related with Habitat and Cover Vegetation
     EqRemovedCV(yr,mn,dy,i)       Eq to estimate invasive cover vegetation that is removed
     EqCost                        Cost of management of cover vegetation
     EqHSI_CVinv(yr,mn,dy,i)       Eq to estimate HSI for especific Cover Vegetation
     EqHSI_CVinv2(yr,mn,dy,wu)     Eq to test HSI=1
     EqBud(yr,mn,dy,wu)            Budget per month and wu
     EqRemovedCV2(yr,mn,dy,wu)      To make sure the removed is lower than present CV.

*Eq related with Habitat and Water
     Eq_WDepth(yr,mn,dy,i)         Eq to estimate Water Depth at each wetland unit
     EqArea(yr,mn,dy,i)            Eq to estimate the flood Area

*    EqWUAW_Stor4(yr,mn,dy,wu)     Eq to find WUAW for a corresponding Volume (interpolation)
*Eq for water depth suitability for old method (assume entire wetland unit at staff gage height)
     EqHSI_spec1(yr,mn,dy,wu,spec)  Eq to find HSI using Gauss modeling
     EqHSI_spec2(yr,mn,dy,wu,spec)
     EqHSI_spec3(yr,mn,dy,wu,spec)
     EqHSI_SumSp(yr,mn,dy,i)       Eq to find a unique HSI considering different species and Weights
     EqHSIcomp(yr,mn,dy,i)        Eq to combine both HSI
     EqWUAW(yr,mn,dy,i)           Eq to estimate the WUAW per species estimated with analytical functions

*Eq for water depth suitability for depth-varying method
     EqDVSGaus(yr,mn,dy,wu,spec)   Eq to find depth-varying suitability area as a function of staff gage height (Double gausian form)
     EqDVSGompertz(yr,mn,dy,wu,spec) Eq to find depth-varying suitability area as a function of staff gage height (Gompertz form)
     EqDVSPoly(yr,mn,dy,wu,spec)   Eq to find depth-varying suitability area as a function of staff gage height (Polynomial form)
     EqWUAW_DVS(yr,mn,dy,wu)        Eq to estimate WUAW using depth-varying habitat suitability
     EqHSIcompDVS(yr,mn,dy,wu)      Eq to combine water depth and invasive vegetation cover habitat suitability indexes for Depth-varying suitability method

*these equations only for gate operation.
*$ontext
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     EqGateActRelease (yr,mn,dy,wu) Eq to identify changes in release (positive and negatives)
     EqGateActDeliv(yr,mn,dy,wu)    Eq to identify changes in delivery (Just negatives)
     EqGateAct2(yr,mn,dy)          Eq to identify the sum of gates release and delivery
     EqGateAct3(yr,mn,dy)          Eq to limit to available gates
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*$offtext

***     EqHSI_UnitManag(yr,mn,dy,wu,spec)
*Compilation

*     EqSimul(yr,mn,dy,i,dem)      Eq used to implement simulation
**    EqSimul(yr,mn,dy,i)
      ObjectiveFunction
       ;


*------------------------------------
* Gate Management
*------------------------------------
*Use this
*$ontext
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

* Incorporating Management of Gates for wetland units .
* After test 7 different approaches  the best performance was the Arcotang approach, described on the Paper
* Arcotang Equa(x,A,B,k2,x0) = (B-A)/(2)*(arctan((x-x0)/k2)/(0.5*PI)+1)+A

*Release
EqGateActRelease(yr,mn,dy,wu)$(ord(yr) EQ 1 and ord(mn)GT 1)..

                  GateActRelease(yr,mn,dy,wu) =e=   (1)/(2)*(arctan(((R(yr,mn,dy,wu) - R(yr,mn-1,dy,wu)$(ord(mn)GT 1))-1.5)/0.01)/(pi/2)+1) +
                                                    (-1)/(2)*(arctan(((R(yr,mn,dy,wu) - R(yr,mn-1,dy,wu)$(ord(mn)GT 1))+1.5)/0.01)/(pi/2)+1)+1    ;


GateActRelease.lo(yr,mn,dy,wu)=0 ;
*GateActRelease.l(yr,mn,dy,wu)=1  ;
*GateActRelease.up(yr,mn,dy,wu)=1  ;

*Using some initial values
*GateActRelease.l(yr,mn,dy,wu)=1 ;

*Delivery
EqGateActDeliv(yr,mn,dy,wu)$(ord(yr) EQ 1 and ord(mn)GT 1)..

                  GateActDeliv(yr,mn,dy,wu) =e= (-1)/(2)*(arctan(((delivery(yr,mn,dy,wu) - delivery(yr,mn-1,dy,wu)$(ord(mn)GT 1))+1.5)/0.01)/(pi/2)+1)+1   ;


GateActDeliv.lo(yr,mn,dy,wu)=0 ;
*GateActDeliv.l(yr,mn,dy,wu)=1  ;
*GateActDeliv.up(yr,mn,dy,wu)=1  ;



*Constraint to limt to the number of units that they can open and close gates.

EqGateAct2(yr,mn,dy)..

                               GateAct(yr,mn,dy)=e= SUM((wu), GateActRelease(yr,mn,dy,wu)+ GateActDeliv(yr,mn,dy,wu))   ;




* Gates management.
EqGateAct3 (yr,mn,dy)..

                                GateAct(yr,mn,dy) =l=  AvalGateAct(mn) ;


*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*$offtext


*------------------------------------
* Mass Balance
*------------------------------------

*  Mass Balance at non-storage nodes:

EqMassBalNonStor(yr,mn,dy,jn)..
         Inflow(yr,mn,dy,jn)
         + SUM(j$Connect(j,jn), Q(yr,mn,dy,j,jn)* lossQ(j,jn))
         - SUM(j$Connect(jn,j), Q(yr,mn,dy,jn,j))
         =E= 0;

* To estimate the flow to go at the outlet
* At the Outlet
EqMassBalNonStor_Out(yr,mn,dy,Out)..

           SUM(j$Connect(j,Out), Q(yr,mn,dy,j,Out)* lossQ(j,Out))  =G= 0 ;



*  Mass Balance at wetland unit:

EqMassBal_WU(yr,mn,dy,wu)..

        Inflow(yr,mn,dy,wu)
         + SUM(j$Connect(j,wu), Q(yr,mn,dy,j,wu)* lossQ(j,wu))
         - SUM(j$Connect(wu,j), Q(yr,mn,dy,wu,j))
        -(Evapo(yr,mn,dy,wu)$(ord(yr) EQ 1 and ord(mn) EQ 1))
        -(Evapo(yr,mn,dy,wu)$(ord(mn) GT 1))
         =E= S(yr,mn,dy,wu)
            - (initStor2(wu)$(ord(yr) EQ 1 and ord(mn) EQ 1))
             - (S(yr,mn--1,dy,wu)$(ord(mn) GT 1))
             - (S(yr-1,mn--1,dy,wu)$(ord(yr) GT 1 and ord(mn) EQ 1))
        ;

*Evaporation
EqEvap(yr,mn,dy,wu)..


                       Evapo(yr,mn,dy,wu)=e=

                                 (Area(yr,mn,dy,wu)*LossEvapo(mn)/10000 )*(0*(EXP(-20*(WDepth(yr,mn,dy,wu)-0.2)))+1*(EXP(20*(WDepth(yr,mn,dy,wu)-0.2))))/((EXP(-20*(WDepth(yr,mn,dy,wu)-0.2)))+(EXP(20*(WDepth(yr,mn,dy,wu)-0.2)))) ;



* Maximum and minimum flow in channels(links):
*MaxQ
EqMaxQ(yr,mn,dy,i,j)$Connect(i,j)..   Q(yr,mn,dy,i,j) =L= MaxQ(i,j);
EqMinQ(yr,mn,dy,i,j)$Connect(i,j)..   Q(yr,mn,dy,i,j) =G= MinQ(i,j);

* Maximum and minimum storage at wetland units:
EqMaxStor(yr,mn,dy,wu).. S(yr,mn,dy,wu) =L= MaxStor(wu);
EqMinStor(yr,mn,dy,wu).. S(yr,mn,dy,wu) =G= MinStor(wu);


Eq_WDepth(yr,mn,dy,wu)..  WDepth(yr,mn,dy,wu) =e=
                                                    BB(wu,mn)*S(yr,mn,dy,wu)+AA(wu,mn)*(1-EXP(-FF(wu,mn)*S(yr,mn,dy,wu)))  ;


WDepth.lo(yr,mn,dy,wu)=0;


*$ontext
* Estimating the Delivery to each wetland unit
EqDelivery(yr,mn,dy,wu)..
         delivery(yr,mn,dy,wu) =E= SUM(j$Connect(j,wu), Q(yr,mn,dy,j,wu))
                                 + Inflow(yr,mn,dy,wu)  ;

* Estimating the Releases to nonstorage nodes
EqRelease(yr,mn,dy,i)$stor(i)..
          R(yr,mn,dy,i)=e= SUM(j$Connect(i,j), Q(yr,mn,dy,i,j)) ;



*$offtext
*============================================================
*Incorporating Habitat Suitability Concepts
*============================================================

*Medium depth
* PHW1, PHW2,....PHW7:Correspond to parameters of the three HSuitability Functions
EqHSI_spec1(yr,mn,dy,wu,"spec1")..  HSI_spec(yr,mn,dy,wu,"spec1") =e=
                                                                            exp(- (power((WDepth(yr,mn,dy,wu)-PHW1),2))/(2*PHW2**2)) ;
*Shallow
EqHSI_spec2(yr,mn,dy,wu,"spec2")..  HSI_spec(yr,mn,dy,wu,"spec2") =e=
                                                                                  exp(- (power((WDepth(yr,mn,dy,wu)-PHW3),2))/(2*PHW4**2)) ;

*Deep
EqHSI_spec3(yr,mn,dy,wu,"spec3")..  HSI_spec(yr,mn,dy,wu,"spec3") =e=

                                                                              WDepth(yr,mn,dy,wu)*PHW5+PHW6*(1- exp(-PHW7*WDepth(yr,mn,dy,wu)));


*Habitat Suitability of three species considering Weights
EqHSI_SumSp(yr,mn,dy,wu)..  HSI_compWD(yr,mn,dy,wu) =e=
*Use this if I don't want to include preferences in units
                                                        (sum(spec,( HSI_spec(yr,mn,dy,wu,spec)*specweight(mn,spec))))/(sum(spec,specweight(mn,spec)));


HSI_spec.up(yr,mn,dy,wu,spec) = 1  ;
HSI_spec.lo(yr,mn,dy,wu,spec) = 0  ;



*============================================================
*Incorporating Habitat Suitability for Coverage Vegetation
*============================================================

*Coverage Vegetation represents the percentage of vegetation present in the wetland unit

*Estimating the Cover invasive vegetation to be removed

EqRemovedCV(yr,mn,dy,wu)..
                          RemovedCV(yr,mn,dy,wu)=e= (( InitCV_iv2(wu)$(ord(yr) EQ 1 and ord(mn) EQ 1)
                               + CVinvasive(yr,mn--1,dy,wu)$(ord(mn) GT 1)
                               + CVinvasive(yr-1,mn--1,dy,wu)$(ord(yr) GT 1 and ord(mn) EQ 1))

*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* Consider % VegResponse of the current CV
* This method is for linear growth
                               + (VegResp(mn)*InitCV_iv2(wu))
*                               + (VegResp(mn)*InitCV_iv(yr,mn,dy,wu))
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                               - CVinvasive(yr,mn,dy,wu));


RemovedCV.up(yr,mn,dy,wu)=VegMag(mn) ;
RemovedCV.lo(yr,mn,dy,wu)=0 ;

*This is to make sure that removed is not greater than the current condition
EqRemovedCV2(yr,mn,dy,wu)..   RemovedCV(yr,mn,dy,wu)=l= CVinvasive(yr,mn,dy,wu);


*------------------------------------
*Cost of Reducction of Cover Vegetation
*------------------------------------

**Used for scenario 4-5-Base Case and Simulation
*^Scalar B  Total Budget to be used in the reducction of invasive vegetation  /180000/;
**Used for scenario 4 increasing 50%
*Scalar B  Total Budget to be used in the reducction of invasive vegetation  /270000/;
**Used for scenario 5  - decreasing %50  of Budget
*^Scalar B  Total Budget to be used in the reducction of invasive vegetation  /90000/;


*Use this equation when I have a Annual budget a dynamic units cost

EqCost..
                 sum ((yr,mn,dy,wu),(RemovedCV(yr,mn,dy,wu))*TotalArea(wu)* UnitCost(mn))  =L= B   ;

*Estimating Cost per month and wu

*This equation is to know how much I spent per month

EqBud(yr,mn,dy,wu).. RemovedCV(yr,mn,dy,wu)*TotalArea(wu)* UnitCost(mn) =e= Bud(yr,mn,dy,wu) ;


*------------------------------------
*Interpolation HSI_ Cover Vegetation
*------------------------------------


CVinvasive.L(yr,mn,dy,wu)=0;
CVinvasive.UP(yr,mn,dy,wu)=1;

*PHV1-PHV4:correspond to parameter for Habitat suitability to reduce invasive vegetation
EqHSI_CVinv(yr,mn,dy,wu)..  HSI_CVinv(yr,mn,dy,wu) =e=


*Seeting the functionn : ((A-D)/(1+((x/C)^B))) + D
* A = minimum asymptote.
* B = slope factor related to the steepness of the curve.
* C = inflection point.
* D = maximum asymptote.


                                                           (((PHV1-PHV4)/(1+(((CVinvasive(yr,mn,dy,wu)+0.001)/PHV3)**(PHV2)))) + PHV4);


**********************************************************************************
* Testing with Habitat suitability related to vegetation cover equal to 1

EqHSI_CVinv2(yr,mn,dy,wu)..  HSI_CVinv(yr,mn,dy,wu) =e= 1 ;

**********************************************************************************

*-----------------------------------------
*Estimate the flood Area
*-----------------------------------------

EqArea(yr,mn,dy,wu)..

                 Area(yr,mn,dy,wu) =e=
*
*^                                        (CC(wu,mn)*(S(yr,mn,dy,wu)**2))+(DD(wu,mn)*S(yr,mn,dy,wu))+ EE(wu,mn) ;
**                                       (CC(wu,mn)*power(((WDepth(yr,mn,dy,wu)- BB(wu,mn))/AA(wu,mn)),2))+(DD(wu,mn)*((WDepth(yr,mn,dy,wu)- BB(wu,mn))/AA(wu,mn)))+ EE(wu,mn);

                                         CC(wu,mn)*(1-EXP(-DD(wu,mn)*(S(yr,mn,dy,wu)-EE(wu,mn))));

Area.up(yr,mn,dy,i)= TotalArea(i);




EqHSIcomp(yr,mn,dy,stor)..
                     HSIcomp(yr,mn,dy,stor) =e=
                                (sum(spec,( HSI_spec(yr,mn,dy,stor,spec)*specweight(mn,spec))))*HSI_CVinv(yr,mn,dy,stor)/(sum(spec,specweight(mn,spec)));

*** Equations for Depth-varying suitability method
*** Break apart by function type

*Double Gassian
EqDVSGaus(yr,mn,dy,wu,spec)$(DWparams(wu,spec,"p0") eq 1)..
         DVS(yr,mn,dy,wu,spec) =e=
               (  DWparams(wu,spec,"p3")*( exp(-(((WDepth(yr,mn,dy,wu)-DWparams(wu,spec,"p1"))*(WDepth(yr,mn,dy,wu)-DWparams(wu,spec,"p1"))/(2*DWparams(wu,spec,"p2")**2)))))
               + DWparams(wu,spec,"p6")*( exp(-(((WDepth(yr,mn,dy,wu)-DWparams(wu,spec,"p4"))*(WDepth(yr,mn,dy,wu)-DWparams(wu,spec,"p4"))/(2*DWparams(wu,spec,"p5")**2))))))
                 * 10000 ;

*Initial Equation (wrong)
*^EqDVSGompertz(yr,mn,dy,wu,spec)$(DWparams(wu,spec,"p0") eq 3)..
*^         DVS(yr,mn,dy,wu,spec) =e=
*^               DWparams(wu,spec,"p1")*exp(-DWparams(wu,spec,"p2")*exp(-DWparams(wu,spec,"p3")*WDepth(yr,mn,dy,wu)));

*Eq. Updated
EqDVSGompertz(yr,mn,dy,wu,spec)$(DWparams(wu,spec,"p0") eq 2)..
         DVS(yr,mn,dy,wu,spec) =e=
               10000*DWparams(wu,spec,"p1")*exp(-DWparams(wu,spec,"p2")*exp(-DWparams(wu,spec,"p3")*WDepth(yr,mn,dy,wu)));


*4th order polynomial
EqDVSPoly(yr,mn,dy,wu,spec)$(DWparams(wu,spec,"p0") eq 3)..
         DVS(yr,mn,dy,wu,spec) =e=
             (   DWparams(wu,spec,"p1")*WDepth(yr,mn,dy,wu)**4 + DWparams(wu,spec,"p2")*WDepth(yr,mn,dy,wu)**3
              + DWparams(wu,spec,"p3")*WDepth(yr,mn,dy,wu)**2 + DWparams(wu,spec,"p4")*WDepth(yr,mn,dy,wu)
              + DWparams(wu,spec,"p5"))*10000;

**Depth varying suitability version of overall objective function for wetland unit
EqWUAW_DVS(yr,mn,dy,wu)..
          WUAW(yr,mn,dy,wu) =e=
              HSI_CVinv(yr,mn,dy,wu)*sum(spec,specweight(mn,spec)*DVS(yr,mn,dy,wu,spec))/
              sum(spec,specweight(mn,spec));

DVS.LO(yr,mn,dy,wu,spec) = 0;
DVS.UP(yr,mn,dy,wu,spec)= TotalArea(wu);

EqHSIcompDVS(yr,mn,dy,wu)..
          HSIcomp(yr,mn,dy,wu) =e=  WUAW(yr,mn,dy,wu)/(TotalArea(wu));



** Old method - using wetted area
EqWUAW(yr,mn,dy,stor)..
             WUAW(yr,mn,dy,stor) =e= (HSI_compWD(yr,mn,dy,stor)*HSI_CVinv(yr,mn,dy,stor)*Area(yr,mn,dy,stor)) ;

*$ontext
*--------------------------------------------------------------------------------------------------------------------------

*-------------------------
*Used for simulation
*-------------------------
* Use 1 for simulation
* Use 2 for automatic gates
ModelType = 2;

*      Conditional to work with GUI input in Simulation
       if ((ModelType eq 1),
*      To proceed with the Simulation model
          S.fx(yr,mn,dy,wu)= DemandHy(yr,mn,dy,wu) ) ;
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*To Optimize


*      To proceed with the Optimization model
ObjectiveFunction..
                    SUM((yr,mn,dy,stor), WUAW(yr,mn,dy,stor)) =E= Obj ;


*===================================
* Solving the Model
*===================================

*MOdel Nov30 /all/
*Old version
Model Nov2015 original version  /EqMassBalNonStor,EqMassBalNonStor_Out,EqMassBal_WU,EqMaxQ,EqMinQ,EqMaxStor,EqMinStor,EqEvap,EqDelivery,EqRelease,EqRemovedCV,EqCost,EqHSI_CVinv,EqBud,EqRemovedCV2,Eq_WDepth,EqHSI_spec1,EqHSI_spec2,EqHSI_spec3,EqHSI_SumSp,EqArea,EqHSIcomp,EqWUAW,ObjectiveFunction/;
*New Version
Model Mar2016_DVS Depth-varying suitability /EqMassBalNonStor,EqMassBalNonStor_Out,EqMassBal_WU,EqMaxQ,EqMinQ,EqMaxStor,EqMinStor,EqEvap,EqDelivery,EqRelease,EqRemovedCV,EqCost,EqHSI_CVinv,EqBud,EqRemovedCV2,Eq_WDepth,EqDVSGaus,EqDVSGompertz,EqDVSPoly,EqWUAW_DVS,EqArea,EqHSIcompDVS,ObjectiveFunction/;
*Old version-Gates: Typically Gate constraint scenario can take more time (around 40 min if we constraint to 4 gates per month)
Model GateConstraint original version with gates contraint /EqMassBalNonStor,EqMassBalNonStor_Out,EqMassBal_WU,EqMaxQ,EqMinQ,EqMaxStor,EqMinStor,EqEvap,EqDelivery,EqRelease,EqRemovedCV,EqCost,EqHSI_CVinv,EqBud,EqRemovedCV2,Eq_WDepth,EqHSI_spec1,EqHSI_spec2,EqHSI_spec3,EqHSI_SumSp,EqArea,EqGateActRelease,EqGateActDeliv,EqGateAct2,EqGateAct3,EqHSIcomp,EqWUAW,ObjectiveFunction/;
*New version-Gates:
Model Mar2016_DVS_GatesConstraint Depth-varying suitability /EqMassBalNonStor,EqMassBalNonStor_Out,EqMassBal_WU,EqMaxQ,EqMinQ,EqMaxStor,EqMinStor,EqEvap,EqDelivery,EqRelease,EqRemovedCV,EqCost,EqHSI_CVinv,EqBud,EqRemovedCV2,Eq_WDepth,EqDVSGaus,EqDVSGompertz,EqDVSPoly,EqGateActRelease,EqGateActDeliv,EqGateAct2,EqGateAct3,EqWUAW_DVS,EqArea,EqHSIcompDVS,ObjectiveFunction/;


option limrow = 10000
option limcol = 10000
OPTION  ITERLIM = 5000000
option profile=3 ;
option reslim = 5000000;
*OA-close it;
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

* ..............................................................................
* SEQUENCE OF SCENARIO RUNS

* 0. Previous Management (Base Case): Simulated
*    Set the storage values to observed values
     S.fx(yr,mn,dy,wu) = DemandHy(yr,mn,dy,wu);

     Solve Mar2016_DVS MAXIMIZING Obj USING NLP ;
     Display Obj.l,  EqCost.m  ;

*    Store results
*    Dump all input data and results to a GAMS gdx file
*^     Execute_Unload "ResultSim.gdx";
*    Also dump the gdx file to an Excel workbook
*^     Execute "gdx2xls ResultSim.gdx";

*^$ontext
*Create a GDX file
execute_unload "ResultSim.gdx" Obj, S,
WUAW,Area,initStor2,Inflow,
TotalArea,MaxStor,
WDepth
HSI_CVinv, InitCV_iv2,CVinvasive,RemovedCV,Bud, EqBud
,EqMassBalNonStor_Out,
HSIcomp,
HSI_spec

*$ontext
execute 'gdxxrw.exe ResultSim.gdx par=InitCV_iv2.l rng=CheckCV!D1:ZZ14 Cdim=1  SQ=N  var=RemovedCV.l rng=CheckCV!A16:ZZ29 SQ=N   var=CVinvasive.l rng=CheckCV!A31:ZZ44 var=Bud.l rng=CheckCV!A46:ZZ59  SQ=N var=HSI_CVinv.l rng=CheckCV!A61:ZZ74 Rdim=3 SQ=N  par=TotalArea.l rng=CheckCV!A77:ZZ107 Cdim=1  par=MaxStor.l rng=CheckCV!A82:ZZ107 Cdim=1'
execute 'gdxxrw.exe ResultSim.gdx var=ROW_Hydro.l rng=ROW_Water!'
execute 'gdxxrw.exe ResultSim.gdx var=WUAW2.l rng=WUAW2! Rdim=4 '
execute 'gdxxrw.exe ResultSim.gdx var=HSIcomp.l rng=HSIcomp! Rdim=4'
execute 'gdxxrw.exe ResultSim.gdx par=Inflow.l rng=CheckWater!A1:AZ14 '
execute 'gdxxrw.exe ResultSim.gdx par=initStor2.l rng=CheckWater!D16:AZ29  SQ=N  '
execute 'gdxxrw.exe ResultSim.gdx  var=S.l rng=CheckWater!A21:AZ34      '
execute 'gdxxrw.exe ResultSim.gdx  var=WDepth.l rng=CheckWater!A36:AZ49   '
execute 'gdxxrw.exe ResultSim.gdx  var=Area.l rng=CheckWater!A51:AZ64 Rdim=3 SQ=N   '
execute 'gdxxrw.exe ResultSim.gdx  var=HSI_CVinv.l rng=CheckWater!A69:BZ82 Rdim=3 Cdim=1'
execute 'gdxxrw.exe ResultSim.gdx var=WUAW.l rng=CheckWater!A86:BZ99 Rdim=3 Cdim=1' ;

*^$offtext
*.............................................................................................

*^$ontext
* 2. Automatic Gates: Optimized depth-varying suitability
*    Set all decision variable levels back to zero
      Q.L(yr,mn,dy,i,j) = 0;
      S.L(yr,mn,dy,i) = 0;
      delivery.L(yr,mn,dy,i) = 0;
      R.L(yr,mn,dy,i) = 0;
      Evapo.L(yr,mn,dy,wu) = 0;
*Variables related with Habitat and Cover Vegetation
      CVinvasive.L(yr,mn,dy,i) = 0;
      RemovedCV.L(yr,mn,dy,i) = 0;
      Bud.L(yr,mn,dy,wu) = 0;

*Variables related with Habitat and Water
      Area.L(yr,mn,dy,i) = 0;
      WDepth.L(yr,mn,dy,i) = 0;

*Compilation
      HSIcomp.L(yr,mn,dy,i) = 0;
      WUAW.L(yr,mn,dy,i) = 0;
      Obj.L = 0;

*Release bounds on storage set in prior scenario
      S.LO(yr,mn,dy,wu) = MinStor(wu);
      S.UP(yr,mn,dy,wu) = MaxStor(wu);

     Solve Mar2016_DVS MAXIMIZING Obj USING NLP ;
     Display Obj.l,  EqCost.m  ;

*    Store results
*    Dump all input data and results to a GAMS gdx file
*^    Execute_Unload "ResultOpt.gdx";
*    Also dump the gdx file to an Excel workbook
*^     Execute "gdx2xls ResultOpt.gdx";


*Create a GDX file
execute_unload "ResultOpt.gdx" Obj, S,
WUAW,Area,initStor2,Inflow,
TotalArea,MaxStor,
WDepth
HSI_CVinv, InitCV_iv2,CVinvasive,RemovedCV,Bud, EqBud
,EqMassBalNonStor_Out,
HSIcomp,
HSI_spec,Q,DVS


execute 'gdxxrw.exe ResultOpt.gdx par=InitCV_iv2.l rng=CheckCV!D1:ZZ14 Cdim=1  SQ=N  var=RemovedCV.l rng=CheckCV!A16:ZZ29 SQ=N   var=CVinvasive.l rng=CheckCV!A31:ZZ44 var=Bud.l rng=CheckCV!A46:ZZ59  SQ=N var=HSI_CVinv.l rng=CheckCV!A61:ZZ74 Rdim=3 SQ=N  par=TotalArea.l rng=CheckCV!A77:ZZ107 Cdim=1  par=MaxStor.l rng=CheckCV!A82:ZZ107 Cdim=1'
execute 'gdxxrw.exe ResultOpt.gdx var=ROW_Hydro.l rng=ROW_Water!'
execute 'gdxxrw.exe ResultOpt.gdx var=WUAW2.l rng=WUAW2! Rdim=4 '
execute 'gdxxrw.exe ResultOpt.gdx var=HSIcomp.l rng=HSIcomp! Rdim=4'
execute 'gdxxrw.exe ResultOpt.gdx par=Inflow.l rng=CheckWater!A1:AZ14 '
execute 'gdxxrw.exe ResultOpt.gdx par=initStor2.l rng=CheckWater!D16:AZ29  SQ=N  '
execute 'gdxxrw.exe ResultOpt.gdx  var=S.l rng=CheckWater!A21:AZ34      '
execute 'gdxxrw.exe ResultOpt.gdx  var=WDepth.l rng=CheckWater!A36:AZ49   '
execute 'gdxxrw.exe ResultOpt.gdx  var=Area.l rng=CheckWater!A51:AZ64 Rdim=3 SQ=N   '
execute 'gdxxrw.exe ResultOpt.gdx  var=HSI_CVinv.l rng=CheckWater!A69:BZ82 Rdim=3 Cdim=1'
execute 'gdxxrw.exe ResultOpt.gdx var=WUAW.l rng=CheckWater!A86:BZ99 Rdim=3 Cdim=1'
execute 'gdxxrw.exe ResultOpt.gdx  var=Q.l rng=CheckWater!A131:ZA145 Rdim=3 SQ=N    '
execute 'gdxxrw.exe ResultOpt.gdx  var=DVS.l rng=CheckWater!A103:BZ116 Rdim=3 Cdim=2  SQ=N ' ;

*^$offtext
*.............................................................................................

*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
* 0. Dummy Run
*    Set the storage values to observed values
     S.fx(yr,mn,dy,wu) = DemandHy(yr,mn,dy,wu);

     Solve Mar2016_DVS MAXIMIZING Obj USING NLP ;
     Display Obj.l,  EqCost.m  ;

*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*^ontext
* 4. Invasive Vegetation 2X
*^Set
*^ivc  invasive vegetation factor to run scenarios /ivc1/
*^^Parameter InitIVCMult(ivc) Initial invasive vegetation cover as a multiple of base case   /ivc2 2/;
*Scalar InitIVCMult2 Factor to multiply the base case of initial invasive vegetation cover /1/;


*   Initialize initial invasive vegetation cover values
    InitCV_iv2(wu) =  InitIVCMult("ivc2") * wu_ts_data2(wu,"InitCViv");
*^    InitCV_iv2(wu) =  InitIVCMult2 * wu_ts_data2(wu,"InitCViv");



*    Set all decision variable levels back to zero
      Q.L(yr,mn,dy,i,j) = 0;
      S.L(yr,mn,dy,i) = 0;
      delivery.L(yr,mn,dy,i) = 0;
      R.L(yr,mn,dy,i) = 0;
      Evapo.L(yr,mn,dy,wu) = 0;
*Variables related with Habitat and Cover Vegetation - InitCV_iv2(i);
      CVinvasive.L(yr,mn,dy,i) =  0;
      RemovedCV.L(yr,mn,dy,i) = 0;
      Bud.L(yr,mn,dy,wu) = 0;

*Variables related with Habitat and Water
      Area.L(yr,mn,dy,i) = 0;
      WDepth.L(yr,mn,dy,i) = 0;

*Compilation
      HSIcomp.L(yr,mn,dy,i) = 0;
      WUAW.L(yr,mn,dy,i) = 0;
      Obj.L = 0;

*Release bounds on storage set in prior scenario
      S.LO(yr,mn,dy,wu) = MinStor(wu);
      S.UP(yr,mn,dy,wu) = MaxStor(wu);


     Solve Mar2016_DVS MAXIMIZING Obj USING NLP ;
     Display Obj.l,  EqCost.m  ;

*    Store results
*    Dump all input data and results to a GAMS gdx file
*^    Execute_Unload "ResultOpt.gdx";
*    Also dump the gdx file to an Excel workbook
*^     Execute "gdx2xls ResultOpt.gdx";

*$ontext
*Create a GDX file
execute_unload "ResultCV2.gdx" Obj, S,
WUAW,Area,initStor2,Inflow,
TotalArea,MaxStor,
WDepth
HSI_CVinv, InitCV_iv2,CVinvasive,RemovedCV,Bud, EqBud
,EqMassBalNonStor_Out,
HSIcomp,
HSI_spec

execute 'gdxxrw.exe ResultCV2.gdx par=InitCV_iv2.l rng=CheckCV!D1:ZZ14 Cdim=1  SQ=N  var=RemovedCV.l rng=CheckCV!A16:ZZ29 SQ=N   var=CVinvasive.l rng=CheckCV!A31:ZZ44 var=Bud.l rng=CheckCV!A46:ZZ59  SQ=N var=HSI_CVinv.l rng=CheckCV!A61:ZZ74 Rdim=3 SQ=N  par=TotalArea.l rng=CheckCV!A77:ZZ107 Cdim=1  par=MaxStor.l rng=CheckCV!A82:ZZ107 Cdim=1'
execute 'gdxxrw.exe ResultCV2.gdx var=ROW_Hydro.l rng=ROW_Water!'
execute 'gdxxrw.exe ResultCV2.gdx var=WUAW2.l rng=WUAW2! Rdim=4 '
execute 'gdxxrw.exe ResultCV2.gdx var=HSIcomp.l rng=HSIcomp! Rdim=4'
execute 'gdxxrw.exe ResultCV2.gdx par=Inflow.l rng=CheckWater!A1:AZ14 '
execute 'gdxxrw.exe ResultCV2.gdx par=initStor2.l rng=CheckWater!D16:AZ29  SQ=N  '
execute 'gdxxrw.exe ResultCV2.gdx  var=S.l rng=CheckWater!A21:AZ34      '
execute 'gdxxrw.exe ResultCV2.gdx  var=WDepth.l rng=CheckWater!A36:AZ49   '
execute 'gdxxrw.exe ResultCV2.gdx  var=Area.l rng=CheckWater!A51:AZ64 Rdim=3 SQ=N   '
execute 'gdxxrw.exe ResultCV2.gdx  var=HSI_CVinv.l rng=CheckWater!A69:BZ82 Rdim=3 Cdim=1'
execute 'gdxxrw.exe ResultCV2.gdx var=WUAW.l rng=CheckWater!A86:BZ99 Rdim=3 Cdim=1'  ;


*$offtext
*......................................................................................
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
* 0. Dummy Run
*    Set the storage values to observed values
     S.fx(yr,mn,dy,wu) = DemandHy(yr,mn,dy,wu);

     Solve Mar2016_DVS MAXIMIZING Obj USING NLP ;
     Display Obj.l,  EqCost.m  ;

*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

*^$ontext
* 5. Invasive Vegetation 3X
*^Set
*^ivc  invasive vegetation factor to run scenarios /ivc1/
*^^Parameter InitIVCMult(ivc) Initial invasive vegetation cover as a multiple of base case   /ivc3 3/;
*Scalar InitIVCMult2 Factor to multiply the base case of initial invasive vegetation cover /1/;


*   Initialize initial invasive vegetation cover values
    InitCV_iv2(wu) =  InitIVCMult("ivc3") * wu_ts_data2(wu,"InitCViv");
*^    InitCV_iv2(wu) =  InitIVCMult2 * wu_ts_data2(wu,"InitCViv");



*    Set all decision variable levels back to zero
      Q.L(yr,mn,dy,i,j) = 0;
      S.L(yr,mn,dy,i) = 0;
      delivery.L(yr,mn,dy,i) = 0;
      R.L(yr,mn,dy,i) = 0;
      Evapo.L(yr,mn,dy,wu) = 0;
*Variables related with Habitat and Cover Vegetation - InitCV_iv2(i);
      CVinvasive.L(yr,mn,dy,i) =  0;
      RemovedCV.L(yr,mn,dy,i) = 0;
      Bud.L(yr,mn,dy,wu) = 0;

*Variables related with Habitat and Water
      Area.L(yr,mn,dy,i) = 0;
      WDepth.L(yr,mn,dy,i) = 0;

*Compilation
      HSIcomp.L(yr,mn,dy,i) = 0;
      WUAW.L(yr,mn,dy,i) = 0;
      Obj.L = 0;

*Release bounds on storage set in prior scenario
      S.LO(yr,mn,dy,wu) = MinStor(wu);
      S.UP(yr,mn,dy,wu) = MaxStor(wu);


     Solve Mar2016_DVS MAXIMIZING Obj USING NLP ;
     Display Obj.l,  EqCost.m  ;

*    Store results
*    Dump all input data and results to a GAMS gdx file
*^    Execute_Unload "ResultOpt.gdx";
*    Also dump the gdx file to an Excel workbook
*^     Execute "gdx2xls ResultOpt.gdx";


*Create a GDX file
execute_unload "ResultCV3.gdx" Obj, S,
WUAW,Area,initStor2,Inflow,
TotalArea,MaxStor,
WDepth
HSI_CVinv, InitCV_iv2,CVinvasive,RemovedCV,Bud, EqBud
,EqMassBalNonStor_Out,
HSIcomp,
HSI_spec

execute 'gdxxrw.exe ResultCV3.gdx par=InitCV_iv2.l rng=CheckCV!D1:ZZ14 Cdim=1  SQ=N  var=RemovedCV.l rng=CheckCV!A16:ZZ29 SQ=N   var=CVinvasive.l rng=CheckCV!A31:ZZ44 var=Bud.l rng=CheckCV!A46:ZZ59  SQ=N var=HSI_CVinv.l rng=CheckCV!A61:ZZ74 Rdim=3 SQ=N  par=TotalArea.l rng=CheckCV!A77:ZZ107 Cdim=1  par=MaxStor.l rng=CheckCV!A82:ZZ107 Cdim=1'
execute 'gdxxrw.exe ResultCV3.gdx var=ROW_Hydro.l rng=ROW_Water!'
execute 'gdxxrw.exe ResultCV3.gdx var=WUAW2.l rng=WUAW2! Rdim=4 '
execute 'gdxxrw.exe ResultCV3.gdx var=HSIcomp.l rng=HSIcomp! Rdim=4'
execute 'gdxxrw.exe ResultCV3.gdx par=Inflow.l rng=CheckWater!A1:AZ14 '
execute 'gdxxrw.exe ResultCV3.gdx par=initStor2.l rng=CheckWater!D16:AZ29  SQ=N  '
execute 'gdxxrw.exe ResultCV3.gdx  var=S.l rng=CheckWater!A21:AZ34      '
execute 'gdxxrw.exe ResultCV3.gdx  var=WDepth.l rng=CheckWater!A36:AZ49   '
execute 'gdxxrw.exe ResultCV3.gdx  var=Area.l rng=CheckWater!A51:AZ64 Rdim=3 SQ=N   '
execute 'gdxxrw.exe ResultCV3.gdx  var=HSI_CVinv.l rng=CheckWater!A69:BZ82 Rdim=3 Cdim=1'
execute 'gdxxrw.exe ResultCV3.gdx var=WUAW.l rng=CheckWater!A86:BZ99 Rdim=3 Cdim=1'  ;


*^$offtext

