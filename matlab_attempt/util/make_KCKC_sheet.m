function [KC_sheet,KCKC_sheet] = make_KCKC_sheet(tree_xml_file,section_name)
% MAKE_KCKC_SHEET - makes the "KC-KC" sheet for KC_linkages.xlsx
%
%   C = make_items_sheet(FNAME) reads in the xml file FNAME that contains
%   the inflated xml output from draw.io. The output is the a cell array 
%   that has the info for KC_linkages.xlsx. This info is also save to its
%   own Excel file
%

% If section isn't an input, get the first word in the filename, e.g.
% basics, arrays, loops, etc.
if nargin<2
   [~,name,~] = fileparts(tree_xml_file);
   words_in_name = strsplit(name);
   section_name = words_in_name{1};
end

% Read in xml file and find 'mxCell' objects that draw.io uses for vertices
% and edges 
DOM_obj = xmlread(tree_xml_file);
allItems = DOM_obj.getElementsByTagName('mxCell');

% Create some empty arrays
KC_IDs = {};
KC_names = {};
vertexIDs = [];
edgeSources = [];
edgeTargets = [];
edgeWeights = {};

% Iterate through mxCells, finding vertices and edges
for k = 1:allItems.getLength
   
    % Get attributes for this node. Numbering for xml DOM objects starts at
    % zero, so subtract 1 from index
    thisItem = allItems.item(k-1);
    [attNames,attValues] = parseAttributes(thisItem);    
    
    % Determine if item is vertex or edge
    if ismember('vertex',attNames) 
        
        % Save id and name
        vertexIDs(end+1) = str2double(attValues(ismember(attNames,'id')));
        
        % Parse vertex name into KC ID and KC name
        vertexName = attValues{ismember(attNames,'value')};        
        brStarts = strfind(vertexName,'<br>');
        if ~isempty(brStarts)
            if length(brStarts)>1
                vertexName = vertexName(1:brStarts(2)-1);
            end
            KC_IDs{end+1} = vertexName(1:brStarts(1)-1);
            KC_names{end+1} = vertexName(brStarts(1)+4:end);
        else
            KC_IDs{end+1} = '';
            KC_names{end+1} = '';
        end

    elseif ismember('edge',attNames)
        
        %Save source and target.
        edgeSources(end+1) = str2double(attValues(ismember(attNames,'source')));
        edgeTargets(end+1) = str2double(attValues(ismember(attNames,'target')));
        
        % Get increased strokeWidth as an indicator of weight. Normal
        % strokeWidths aren't in the style string, so just check for
        % presence
        style = attValues{ismember(attNames,'style')};
        if strfind(style,'strokeWidth')
            edgeWeights{end+1} = 'Strong';
        else
            edgeWeights{end+1} = 'Weak';
        end
        
    end

end

% Make KC_sheet. Just the ids and names
KC_sheet = [KC_IDs' KC_names'];

% Iterate through edges, adding line to an output file for each connection.
%
% Format is:
%   Post-req KC ID, '', Pre-req KC ID, '', Connection strength
%
% In our graph lines point from post-req to pre-re, so source is placed
% first
KCKC_sheet = {};
for iEdge = 1:length(edgeSources)
    source_ID = KC_IDs{vertexIDs==edgeSources(iEdge)};
    target_ID = KC_IDs{vertexIDs==edgeTargets(iEdge)};
    source_name = KC_names{vertexIDs==edgeSources(iEdge)};
    target_name = KC_names{vertexIDs==edgeTargets(iEdge)};
    KCKC_sheet(end+1,1:5) = {source_ID,source_name,target_ID,target_name, ...
        edgeWeights{iEdge}};
end
end


function varargout = parseAttributes(theNode)
% Create attributes structure.
%
%   S = parseAttributed(N) takes in a XML node N and returns the
%   attributes for this node.
%   The output S is an array of structs with length equal to the number of
%   found attributes
%
%   [NAMES,VALUES] = parseAttributes(N) returns two cell arrays of the same
%   size (NAMES and VALUES) that have the attributes from this node.


attributes = [];
if theNode.hasAttributes
   theAttributes = theNode.getAttributes;
   numAttributes = theAttributes.getLength;
   allocCell = cell(1, numAttributes);
   attributes = struct('Name', allocCell, 'Value', ...
                       allocCell);

   for count = 1:numAttributes
      attrib = theAttributes.item(count-1);
      attributes(count).Name = char(attrib.getName);
      attributes(count).Value = char(attrib.getValue);
   end
end

if nargout==1
    varargout = {attributes};
elseif nargout==2
    varargout = {{attributes.Name},{attributes.Value}};
end
end