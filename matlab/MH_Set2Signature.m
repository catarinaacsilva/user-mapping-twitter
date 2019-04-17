###############################################################################
# Creates MinHash Signatures from a Set Matrix
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################
# Uses MH_Hash to generate hash based on universal hashing

function S = MH_Set2Signature(MS, k)
  # Init the Signature matrix with infinity
  S = Inf(k, size(MS)(2));
  
  # For all shingles
  for i = 1:size(MS)(1)
    hash = MH_Hash(i, k);
    for j = 1:size(MS)(2)
      if MS(i,j) == 1
        for h = 1:k
          if hash(h) < S(h, j)
            S(h, j) = hash(h); 
          end
        end
      end
    end
  end