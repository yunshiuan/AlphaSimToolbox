function varargout = restplus(AOperation, varargin)
% RESTplus a resting state fMRI data analysis toolkit by Xi-ze Jia
% Update from REST toolkit
%-----------------------------------------------------------
%	Copyright(c) 2007~2010
%	Written by Xi-ze Jia 
% 	Mail to Authors:  <a href="jiaxize@foxmail.com">Jia Xi-ze</a>; 
%	Version=1.2;
%	Release=20170202;


if nargin<1
   AOperation='Init';
end


switch upper(AOperation),
    case 'INIT' %Init
        InitControls();
end





end



function InitControls()

%      DefaultColorBackground=[110/250,106/250,105/250]; 1st
%.....
      DefaultColorBackground=[225/250,224/250,223/250];
      frame_background_color=[208 207 203]/250;
%....
    
    
    [theVersion theRelease]=rp_misc( 'GetRestVersion');
    offsetup=50;
    default_fontsize=16;
    
    fprintf('RESTplus %s_%s' ,theVersion,theRelease);
    fprintf('\nThanks a lot for your email to Jia Xi-Ze (jiaxize@foxmail.com) for any suggestion\n');
    
	theFig =figure('Units', 'pixel',...
                  'Toolbar', 'none',...
                  'MenuBar', 'none', ...
			      'NumberTitle', 'off',...
                  'Visible', 'on', ...					
			      'Name', sprintf('RESTplus %s_%s' ,theVersion,theRelease), ...
			      'Position', [0,0,500, 400+offsetup],...
                  'Resize','off', ...
				  'Color', DefaultColorBackground);
				  %'DeleteFcn', sprintf('rest(''QuitAll'');')  );
    movegui(theFig, 'northwest'); 
    
%    uicontrol(theFig,'Style','Frame','Position', ...
% 			[20 300 460 145], ...
% 			'BackgroundColor', [1 1 1]*.0);
   uicontrol(theFig,'Style','Frame','Position', ...
			[20 300 460 145], ...
			'BackgroundColor', frame_background_color);    
	uicontrol(theFig,'Style','Text','Position',[145 360 270 55],...
		'String','RESTplus',...
        'fontunit','pix',...
		'FontSize',45, ...		
		'FontWeight','Bold',...
        'HorizontalAlignment','left',...
		'ForegroundColor',[0 0 0],...
        'BackgroundColor', frame_background_color);     
     
	uicontrol(theFig,'Style','Text','Position',[90 325 380 20],...
		'String','A Resting State fMRI Data Analysis Toolkit',...
         'HorizontalAlignment','left',...
        'fontunit','pix',...
		'FontSize',14, ...		
		'FontWeight','Bold',...
		'ForegroundColor',[132 132 132]/250,'BackgroundColor', frame_background_color);     
    
%     uicontrol(theFig,'Style','Frame','Position', ...
% 			[20 20 460 270], ...
% 			'BackgroundColor', [148/250 196/250 145/250]);
    uicontrol(theFig,'Style','Frame','Position', ...
			[20 20 460 270], ...
			'BackgroundColor',frame_background_color);  
    pushbtn_size=[150 50];    
    uicontrol(theFig,'Style','pushbutton',...
            'Position',[60 140+offsetup pushbtn_size],...
            'String','Pipeline',...
            'ToolTipString','RESTplus pipeline toolkit', ...
            'fontunit','pix',...
            'FontSize',default_fontsize,...
            'Callback', sprintf('repipl;'));

        
   uicontrol(theFig,'Style','pushbutton',...
            'Position',[265 140+offsetup pushbtn_size],...
            'String','Statistical Analysis',...
            'ToolTipString','RESTplus statistical analysis toolkit', ...
            'fontunit','pix',...
            'FontSize',default_fontsize,...
            'Callback', sprintf('rp_Statistic_gui;')); 
        
        
   uicontrol(theFig,'Style','pushbutton',...
            'Position',[60 80+offsetup pushbtn_size],...
            'String','Utilities',...
            'ToolTipString','RESTplus utilities toolkit', ...
            'fontunit','pix',...
            'FontSize',default_fontsize,...
            'Callback', sprintf('rp_Utilities_gui;'));
        
   uicontrol(theFig,'Style','pushbutton',...
            'Position',[265 80+offsetup pushbtn_size],...
            'String','Viewer',...
            'ToolTipString','RESTplus viewer', ...
            'fontunit','pix',...
            'FontSize',default_fontsize,...
            'Callback', sprintf('rp_sliceviewer;'));    
        
        
RP_handle.help =  uicontrol(theFig,'Style','pushbutton',...
            'Position',[60 20+offsetup pushbtn_size],...
            'String','Help',...
            'ToolTipString','RESTplus help', ...
            'fontunit','pix',...
            'FontSize',default_fontsize);    
        
RP_handle.quit = uicontrol(theFig,'Style','pushbutton',...
            'Position',[265 20+offsetup pushbtn_size],...
            'String','Quit',...
            'ToolTipString','RESTplus Quit', ...
            'fontunit','pix',...
            'FontSize',default_fontsize);     
        
  set(RP_handle.help,'callback',{@RESTplus_help});
  set(RP_handle.quit,'callback',{@RESTplus_quit,theFig});
       
  set(theFig,'visible','on');
end


function RESTplus_help(hObject, eventdata)
web('www.restfmri.net');
end


function RESTplus_quit(hObject, eventdata,theFig)
delete(theFig);
end



