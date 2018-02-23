% TESTarcmakemenuCB.m
%
% Implements the callbacks from the menu system in a separate CB file.
%
% We used to split the Tag into Major/Minor/Tertiary Tags,
% but it makes no logical sense to do this on a flat-file database Tag....
function CFh = TESTarcmakemenuCB (varargin)
  
  if nargin > 0 % Action, not callback
    if isstr (varargin{1})
      % Process, using strcmpi
      
    endif
    % return if not doing anything. Previously handled in the Tag....
    return ;
  endif
  
  % Callback processing via Switchyard.
  CFh = get (0, 'CurrentFigure');
  CBh = get (0, 'CallBackObject');
  if ishandle (CFh)
    ud = get(CFh, 'UserData');
    % What do I do if not a handle?
  endif
  if ishandle (CBh)
    CBTag = lower(get (CBh, 'Tag')) % let it print :-)
  endif
  
  
  
  % Actual SwitchYard...
  % Use FULL Tags in a flat switch. Can be in order, but keep it sane :-)
  % Can also chop into major/minor/tertiary tags using strtok on '.'

  switch CBTag
  case 'file.open.data_file...',
    [filNameIP,filPathIP] = uigetfile ('*.txt','Data File');
    ud.filIP=fullfile(filPathIP, filNameIP);
    set (CBh, 'Checked', 'On'); %Indicate that we have done this.
    set (CFh, 'UserData', ud);
    enableSave(CFh);
  case 'file.open.output_file...',
    [filNameOP,filPathOP] = uiputfile ('output.out','Output File');
    ud.filOP=fullfile(filPathOP, filPathOP);
    set (CBh, 'Checked', 'On'); %Indicate that we have done this.
    set (CFh, 'UserData', ud);
    enableSave(CFh);
  case 'file.save'
    saveAllFiles;
  case 'file.exit'
    btn=questdlg('Close TESTarcmakemenu?','Close Application',...
                 '&Yes','&No','&No');
    if strcmpi(btn,'&Yes')
      close(CFh);
    endif;

  % case options stuff.... eg implement a choice
  case {'options.type.rectangular',...
        'options.type.polar',...
	'options.type.smith_chart'}
    CBhParent = get (CBh, 'Parent');
    CBhSiblings = get (CBhParent, 'Children');
    set (CBhSiblings, 'Checked','Off');
    set (CBh, 'Checked','On');
    % Implement something based on the choice..., or store it...

  % ignore all other CallBack tags :-)  
  endswitch ;
endfunction ;


% Subfunctions are the obvious place for things that take up a bit more
% processing, that will clutter the SwitchYard structure.

function saveAllFiles ()
  % Save all data....
endfunction ;


function enableSave (CFh)
  % If we have opened a file, we now need to allow the save button to be
  % non-greyed.
  ud = get (CFh, 'UserData');
  myhandle=findobj(ud.handle.menu, 'flat', 'Tag', 'File.Save');
  set (myhandle, 'Enable', 'On');
endfunction ; 




