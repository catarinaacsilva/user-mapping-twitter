###############################################################################
# Creates Shingles from Strings in Cell Arrays
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################

function S = MH_Shingles(txt, shingle_size)
  l = size(txt)(2) - shingle_size + 1;
  for i = 1:l
    t='';
    for j = i:(i + shingle_size - 1)
      t = strcat(t, txt{j});
    end
    S{i} = t;
  end