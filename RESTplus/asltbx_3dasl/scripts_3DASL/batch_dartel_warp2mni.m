% File: batch_dartel_warp2mni.m
% batch warp the jd*c1 image to MNI space.
% Toolbox for batch processing ASL perfusion based fMRI data.
% All rights reserved.
% Ze Wang @ TRC, CFN, Upenn 2004
% This file is made specifically for the longitudinal data. segmentation is
% applied to the mean image of the longitudinal scans
ST=1;   % right now we only consider the first T1 scan
imgs=[];
fields=[];
jdfiles=[];
for sb=1:PAR.nsubs
    for s=2%1:PAR.subs(sb).nsess   % avg image is saved in the folder of the first session
        uf=spm_select('FPList', PAR.subs(sb).ses(ST).structdir{ST}, ['^u_rc1avg_.*\.nii']);   % note we use the average T1 between day1 and day2 for spatial normalization
        for j=1:PAR.subs(sb).ses(s).nasl
            if isempty(uf)
                fprintf('No u field map found for %s \n', PAR.subs(sb).ses(s).structdir{ST});
                fprintf('\t We will skip this subject.\n');
                continue;
            else
%                 jf=spm_select('FPList',
%                 PAR.subs(sb).ses(s).aslfolders{j}, ['^CBF\.nii']);
                jf=spm_select('FPList', PAR.subs(sb).ses(s).aslcbffolders{j}, ['^' PAR.aslcbffilters{1} '.*.nii']);
                if isempty(jf)
                    fprintf('No jd map found for %s \n', PAR.subs(sb).ses(s).structdir{ST});
                    fprintf('\t We will skip this subject.\n');
                    continue;
                end
            end
            fields=strvcat(fields, uf);
            jdfiles=strvcat(jdfiles, jf);
        end
    end
end
template=fullfile(PAR.root,PAR.localtemplate, 'Template_6.nii');
ASLtbx_dartelwarp2mni_manysubs(template, fields, jdfiles, 0);




