###############################################################################
# Check if a key is in a Cell Array
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################

function member = IsMember(key, List)
  member = any(strcmp(List, key));