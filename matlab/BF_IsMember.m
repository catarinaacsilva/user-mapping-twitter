###############################################################################
# Check if a key is a member of the BloomFilter
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################

function member = BF_IsMember(B, k, key)
  count = 0;
  for i = 1:k
    if B(BF_Hash(key, i, length(B))) == 1
      count = count + 1;
    else
      break
    end
  end
  
  if count == k
    member = 1;
  else 
    member = 0;
  end 