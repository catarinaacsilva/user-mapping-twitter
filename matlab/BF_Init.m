###############################################################################
# Creates a BloomFilter with the stop words
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################

function B = BF_Init(filename, m, k)
  SW = ReadTextFile(filename);
  B = zeros(1,m);
  for i=1:size(SW)(2)
    B = BF_Insert(B, k, SW{i});
  end