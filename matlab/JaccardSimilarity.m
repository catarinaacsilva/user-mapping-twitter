###############################################################################
# Conventional Jaccard Similarity
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################
#
# It does not rely on MinHash

function JS = JaccardSimilarity(MS)
  # Init similarity matrix with K valeu
  JS = ones(size(MS)(2));
  
  # Computes the similarities
  for i = 1:size(MS)(2)-1
    for j = i+1:size(MS)(2)
      c = sum(and(MS(:,i), MS(:,j))) / sum(or(MS(:,i), MS(:,j)));
      JS(i, j) = c;
      JS(j, i) = c;
    end
  end