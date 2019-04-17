###############################################################################
# Multiple Hash methods implemented
###############################################################################
# Author:
# --> Catarina Silva
###############################################################################
#
# Original function in:
# http://www.mathworks.com/matlabcentral/fileexchange/27940-string2hash/content/string2hash.m
# Expended to support sdbm, fnv1a and joath algorithms

function hash=String2Hash(str, type)

str=double(str);
if(nargin<2), type='djb2'; end
switch(type)
    case 'djb2'
        hash = 5381*ones(size(str,1),1); 
        for i=1:size(str,2), 
            hash = mod(hash * 33 + str(:,i), 2^32-1); 
        end
    case 'sdbm'
        hash = zeros(size(str,1),1);
        for i=1:size(str,2), 
            hash = mod(hash * 65599 + str(:,i), 2^32-1);
        end
    case 'fnv1a'
      hash = 14695981039346656037;
      for i = 1:size(str, 2)
        hash = bitxor(hash, str(:,i));
        #hash = hash * 1099511628211;
        hash = mod(hash * 1099511628211, 2^64-1);
      end
    case 'joath'
      hash = 0;
      for i=1:size(str,2)
        hash = hash + str(:,i);
        hash = bitshift(hash, 10);
        hash = bitxor(hash, bitshift(hash, 6));
      end
      hash = hash + bitshift(hash, 3);
      hash = bitxor(hash, bitshift(hash, 11));
      hash = hash + bitshift(hash, 15);
    otherwise
        error('string_hash:inputs','unknown type');
end