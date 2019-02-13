function varargout=InitStruct_BasicVersion(AOperation,handles,varargin)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



Ifdo=InitGUIvalue(handles);           
           
switch upper(AOperation)
    case upper('ParametersListboxArray')
         varargout{1}=Init_ParametersListboxArray(Ifdo);
    case upper('ProcessArray')
         varargout{1}=Init_ProcessArray(Ifdo);
    otherwise
        error('InitStruct_BasicVersion');
end
end

function Ifdo=InitGUIvalue(handles)
% Dicom to Nifti..........................
    Ifdo.DicomToNifti=get(handles.UIhandles.DicomToNiftiChekbox.handle,'value');
    Ifdo.EpiDicomtoNifti =get(handles.hPara.DicomToNifti.EpiChekbox,'value');
    Ifdo.T1DicomToNifti =get(handles.hPara.DicomToNifti.T1Chekbox,'value');
    if 0==Ifdo.DicomToNifti
       Ifdo.EpiDicomtoNifti=0;
       Ifdo.T1DicomToNifti=0;
    end
% Remove first time points.......................... 
    Ifdo.RemoveFirstTimePoints=get(handles.UIhandles.RemoveFirstTimePointsChekbox.handle,'value');
% Slice Timing....................   
    Ifdo.SliceTiming =get(handles.UIhandles.SliceTimingChekbox.handle,'value');
% Realign....................      
    Ifdo.Realign =get(handles.UIhandles.RealignChekbox.handle ,'value');
% Reorient....................
    Ifdo.Reorient =get(handles.UIhandles.ReorientChekbox.handle ,'value');
    Ifdo.ReorientBeforeCoregister=get(handles.hPara.Reorient.BeforeCoregiser,'value');
    Ifdo.ReorientAfterCoregister=get(handles.hPara.Reorient.AfterCoregiser,'value');

    if 1==Ifdo.ReorientBeforeCoregister
        Ifdo.ReorientFunBeforeCoregister=1;
        Ifdo.ReorientT1BeforeCoregister=1;
    else
        Ifdo.ReorientFunBeforeCoregister=0;
        Ifdo.ReorientT1BeforeCoregister=0;
    end

    if 1==Ifdo.ReorientAfterCoregister
        Ifdo.ReorientT1AfterCoregister=1;
    else
        Ifdo.ReorientT1AfterCoregister=0;   
    end

    if 0==Ifdo.Reorient
        Ifdo.ReorientFunBeforeCoregister=0;
        Ifdo.ReorientT1BeforeCoregister=0;   
        Ifdo.ReorientT1AfterCoregister=0;       
    end
% Normalize....................    
    Ifdo.Normalize=get(handles.UIhandles.NormalizeChekbox.handle,'value');
    Ifdo.NormalizeEpi =get(handles.hPara.Normalize.EpiRadiobutton ,'value');
    Ifdo.NormalizeSeg=get(handles.hPara.Normalize.T1segRadiobutton,'value');
    Ifdo.NormalizeNewSeg_dartel=get(handles.hPara.Normalize.T1NewSeg_dartel_Radiobutton,'value');
    Ifdo.NormalizeSymSeg=get(handles.hPara.Normalize.SymT1segRadiobutton,'value');
    
    if 1==Ifdo.NormalizeSeg
       Ifdo.T1CoregisterFun=1;
       Ifdo.T1Segment=1;
    else 
       Ifdo.T1CoregisterFun=0;
       Ifdo.T1Segment=0;
    end
    
    if 1==Ifdo.NormalizeEpi
        Ifdo.NormalizeEpi=1;
    else
        Ifdo.NormalizeEpi=0;
    end
    
    if 1==Ifdo.NormalizeNewSeg_dartel
        Ifdo.NormalizeNewSeg_dartel=1;
    else
        Ifdo.NormalizeNewSeg_dartel=0;
    end
    
    if 1==Ifdo.NormalizeSymSeg
        Ifdo.NormalizeSymSeg=1;
    else
        Ifdo.NormalizeSymSeg=0;
    end
    
    
    
    if 0==Ifdo.Normalize
       Ifdo.NormalizeEpi=0;
       Ifdo.NormalizeSeg=0;
       Ifdo.NormalizeSymSeg=0;
       Ifdo.NormalizeNewSeg_dartel=0;
       Ifdo.T1CoregisterFun=0;
       Ifdo.T1Segment=0;
    end
% Smooth....................        
    Ifdo.Smooth =get(handles.UIhandles.SmoothChekbox.handle ,'value');
% Detrend....................           
    Ifdo.Detrend =get(handles.UIhandles.DetrendChekbox.handle ,'value');
% Filter....................      
    Ifdo.Filter =get(handles.UIhandles.FilterChekbox.handle ,'value');
% RegressOutCovariates....................          
    Ifdo.RegressOutCovariates =get(handles.UIhandles.RegressOutCovariatesChekbox.handle ,'value');
% Postprocess.............    
    Ifdo.Alff =get(handles.UIhandles.AlffRadioBtn.handle ,'value');
    Ifdo.fALFF =get(handles.UIhandles.fALFFRadioBtn.handle ,'value');
    Ifdo.KccReHo=get(handles.UIhandles.KccReHoRadioBtn.handle,'value');
    Ifdo.CoHeReHo=get(handles.UIhandles.CoheReHoRadioBtn.handle,'value');    
    Ifdo.VMHC =get(handles.UIhandles.VMHCRadioBtn.handle,'value');
    Ifdo.PerAF =get(handles.UIhandles.PerAFRadioBtn.handle ,'value');
    Ifdo.DegreeCentrality =get(handles.UIhandles.DegreeCentralityRadioBtn.handle ,'value');
    Ifdo.FunConnectivity=get(handles.UIhandles.FunConnectivityRadioBtn.handle,'value');
    Ifdo.GCA=get(handles.UIhandles.GCARadioBtn.handle,'value');
end



function ParametersListboxArray = Init_ParametersListboxArray(Ifdo)
NoEpiPostfix='';
NoT1Postfix='';
ParametersListboxArray=...
 {get_RunStr('DicomToNifti'),          Ifdo.DicomToNifti,              NoEpiPostfix,                        NoT1Postfix;...
  get_RunStr('RemoveFirstTimePoints'), Ifdo.RemoveFirstTimePoints,     get_Postfix('RemoveFirstTimePoints'),NoT1Postfix;...
  get_RunStr('SliceTiming'),           Ifdo.SliceTiming,               get_Postfix('SliceTiming'),          NoT1Postfix;...
  get_RunStr('Realign'),               Ifdo.Realign,                   get_Postfix('Realign'),              NoT1Postfix;...
  get_RunStr('Reorient'),              Ifdo.Reorient,                   NoEpiPostfix,                       NoT1Postfix;...
  get_RunStr('Normalize'),             Ifdo.Normalize,                 get_Postfix('Normalize'),            NoT1Postfix;...
  get_RunStr('Smooth'),                Ifdo.Smooth,                    get_Postfix('Smooth'),               NoT1Postfix;...
  get_RunStr('Detrend'),               Ifdo.Detrend,                   get_Postfix('Detrend'),              NoT1Postfix;...
  get_RunStr('RegressOutCovariates'),  Ifdo.RegressOutCovariates,      get_Postfix('RegressOutCov')         NoT1Postfix;... 
  get_RunStr('Filter'),                Ifdo.Filter,                    get_Postfix('Filter'),               NoT1Postfix;...
  get_RunStr('Alff'),                  Ifdo.Alff,                        NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('fALFF'),                 Ifdo.fALFF,                       NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('KccReHo'),               Ifdo.KccReHo,                     NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('CoHeReHo'),              Ifdo.CoHeReHo,                    NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('VMHC'),                  Ifdo.VMHC,                        NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('PerAF'),                 Ifdo.PerAF,                       NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('DegreeCentrality'),      Ifdo.DegreeCentrality,            NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('FunctionalConnectivity'),Ifdo.FunConnectivity,             NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('GCA'),                   Ifdo.GCA,                         NoEpiPostfix,                      NoT1Postfix;...
 };
end


function ProcessArray=Init_ProcessArray(Ifdo)
NoEpiPostfix='';
NoT1Postfix='';
ProcessArray=...
 {get_RunStr('EpiDicomtoNifti'),       Ifdo.EpiDicomtoNifti,            get_Postfix('DicomToNifti'),        NoT1Postfix;...
  get_RunStr('T1DicomToNifti'),        Ifdo.T1DicomToNifti,             NoEpiPostfix,                       get_Postfix('DicomToNifti');...
  get_RunStr('RemoveFirstTimePoints'), Ifdo.RemoveFirstTimePoints,     get_Postfix('RemoveFirstTimePoints'),NoT1Postfix;...
  get_RunStr('SliceTiming'),           Ifdo.SliceTiming,               get_Postfix('SliceTiming'),          NoT1Postfix;...
  get_RunStr('Realign'),               Ifdo.Realign,                   get_Postfix('Realign'),              NoT1Postfix;...
  get_RunStr('ReorientFunBeforeCoreg'),Ifdo.ReorientFunBeforeCoregister,NoEpiPostfix,                       NoT1Postfix;...
  get_RunStr('ReorientT1BeforeCoreg'), Ifdo.ReorientT1BeforeCoregister, NoEpiPostfix,                       NoT1Postfix;...
  get_RunStr('NormalizeEpi'),          Ifdo.NormalizeEpi,              get_Postfix('Normalize'),            NoT1Postfix;...
  get_RunStr('T1CoregisterFun'),       Ifdo.T1CoregisterFun,            NoEpiPostfix,                      get_Postfix('T1CoregisterFun');...
  get_RunStr('ReorientT1AfterCoreg'),  Ifdo.ReorientT1AfterCoregister, NoEpiPostfix,                        NoT1Postfix;...
  get_RunStr('T1Segment'),             Ifdo.T1Segment,                  NoEpiPostfix,                      get_Postfix('T1Segment');...
  get_RunStr('NormalizeSeg'),          Ifdo.NormalizeSeg,              get_Postfix('Normalize'),            NoT1Postfix;...
  get_RunStr('NormalizeNewSeg_dartel'),Ifdo.NormalizeNewSeg_dartel,    get_Postfix('Normalize'),           [get_Postfix('T1CoregisterFun') get_Postfix('NewSegment')];...
  get_RunStr('NormalizeSymSeg'),       Ifdo.NormalizeSymSeg,           get_Postfix('Normalize'),            NoT1Postfix;...  
  get_RunStr('Smooth'),                Ifdo.Smooth,                    get_Postfix('Smooth'),               NoT1Postfix;...
  get_RunStr('Detrend'),               Ifdo.Detrend,                   get_Postfix('Detrend'),              NoT1Postfix;...
  get_RunStr('RegressOutCovariates'),  Ifdo.RegressOutCovariates,      get_Postfix('RegressOutCov')         NoT1Postfix;...  
  get_RunStr('Filter'),                Ifdo.Filter,                    get_Postfix('Filter'),               NoT1Postfix;...
  get_RunStr('Alff'),                  Ifdo.Alff,                        NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('fALFF'),                 Ifdo.fALFF,                       NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('KccReHo'),               Ifdo.KccReHo,                     NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('CoHeReHo'),              Ifdo.CoHeReHo,                    NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('FunctionalConnectivity'),Ifdo.FunConnectivity,             NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('VMHC'),                  Ifdo.VMHC,                        NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('PerAF'),                 Ifdo.PerAF,                       NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('DegreeCentrality'),      Ifdo.DegreeCentrality,            NoEpiPostfix,                      NoT1Postfix;...
  get_RunStr('GCA'),                   Ifdo.GCA,                         NoEpiPostfix,                      NoT1Postfix
};

end
