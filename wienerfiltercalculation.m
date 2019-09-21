function s=wienerfiltercalculation(g,M)


nhood=[M M];
noise=0.025;
%----------------------------------

%class dogrulama

classin = class(g);
classChanged = false;
if ~isa(g, 'double')
  classChanged = true;
  g = im2double(g);
end

% Estimate the local mean of f.
 shape = 'same';
localMean = filter2(ones(nhood), g,shape) / prod(nhood);

% Estimate of the local variance of f.
localVar = filter2(ones(nhood), g.^2) / prod(nhood) - localMean.^2;
% Compute result
% f = localMean + (max(0, localVar - noise) ./ ...
%           max(localVar, noise)) .* (g - localMean);
%

s = g - localMean;
g = localVar - noise; 
g = max(g, 0);
localVar = max(localVar, noise);
s = s ./ localVar;
s = s .* g;
s = s + localMean;

if classChanged
  s = images.internal.changeClass(classin, s);
end

end