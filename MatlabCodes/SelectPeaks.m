function [top,loc,width,prominence] = SelectPeaks(top,loc,width,prominence,s)

% s = 0.1; %%阈值

select = prominence < s;


% for n=1:length(top)
%     if prominence(n) < s
% 
%         select(i) = n;
%         i = i+1;
% 
% 
%     end
% end

top(:,select) = [];
loc(:,select) = [];
width(:,select) = [];
prominence(:,select) = [];

