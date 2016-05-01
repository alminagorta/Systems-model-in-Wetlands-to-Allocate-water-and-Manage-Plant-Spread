%% Figure SM1: Sigmoidal function- Gate Management
%Updated: July 3-2015
%Developed by Omar Alminagorta
%Dept. of Civil & Environmental Engineering and Utah Water Research Lab
%Utah State University
% o.alminagorta@aggiemail.usu.edu  
%
% If you use the code, cite as:
% Alminagorta, O., D. E. Rosenberg, and K. M. Kettenring, Systems modeling to improve  the  hydro-ecological  performance  of
% diked  wetlands, (Under Review to resubmit to Water Resources Research Journal).

%   Licensing:
% Copyright (c) 2015, Omar Alminagorta and David E. Rosenberg
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% 1. Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
% 
% 2. Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution.
% 
% 3. Neither the name of the copyright holder nor the names of its
%   contributors may be used to endorse or promote products derived from
%   this software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

%% Code to plot Sigmoidal Function 
close all, clear all, clc
[A,textA]=xlsread('PlotFunctionsPaper.xlsx','Sigmoid','A1:C2100');
X1=A(:,1);
Y1=A(:,2);
Y2=A(:,3);


 YMatrix1=[Y1,Y2];
% %Here is the fucntion in Matlab to create the plot
FunctionNeededToFigSM1 (X1, YMatrix1);
