###############################################################################
# Hash Method for MinHash
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################
#
# Creates multiple hash based on two.
# It uses universal hashing to generate two differente hash.
# Due to the parameters from universal hashing, this code is optimize for this
# dataset only.

function h = MH_Hash(x, n)
  a = Universal_Hashing(x, 78, 566, 65761, n);
  b = Universal_Hashing(x, 34, 312, 65867, n);
  h = zeros(1,n);
  for i = 1:n
    h(i) = mod(int64((a+b*i)), n);
    #h(i) = mod(int64((a+b*i)), 2^32-1);
  end