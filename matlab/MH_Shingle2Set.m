###############################################################################
# Creates a Set Matrix from the Shingles
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################

function MS = MH_Shingle2Set(LS)
  # Identify  Unique Shingles
  US = {};
  u = 1;
  for i = 1:size(LS)(2)
    for j = 1:size(LS{i})(2)
      if ~any(strcmp(US, LS{i}{j}))
        US{u} = LS{i}{j};
        u = u + 1;
      end
    end
  end
  
  # Create Boolean Matrix that Represents the Set
  MS = zeros(size(US)(2), size(LS)(2));
  
  # Fill the Set Matrix with membership
  for i = 1:size(US)(2)
    shingle = US{i};
    for j = 1:size(LS)(2)
      if any(strcmp(LS{j}, shingle))
        MS(i, j) = 1;
      end
    end
  end