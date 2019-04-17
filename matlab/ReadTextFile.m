###############################################################################
# Reads a text file and puts the content in a cell array
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################

function txt = ReadTextFile(filename)
  fid = fopen(filename);
  i = 1;
  while (! feof(fid) )
    txt{i} = fgetl(fid);
    i = i + 1;
  end
  fclose(fid);