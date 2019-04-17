###############################################################################
# Reads tweets words from text file and removes the Stop Words
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################
# It uses a bloom filter to filter out the stop words

function T = ReadTweetsRemoveStopWords(filename, BF, k)
  fid = fopen(filename);
  i = 1;
  while (! feof(fid) )
    s = fgetl(fid);
    if BF_IsMember(BF, k, s) == 0
      T{i} = s;
      i = i + 1;
    end
  end
  fclose(fid);