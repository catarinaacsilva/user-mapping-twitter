###############################################################################
# Computes the Jaccard Similarity from the Signature Matrix
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################

function JS = MH_JaccardSimilarity(S)
  # Init similarity matrix with K valeu
  JS = ones(size(S)(2));
  JS = JS .* size(S)(1);
  
  # Computes the similarities
  for i = 1:size(S)(2)-1
    for j = i+1:size(S)(2)
      c = sum(S(:,i) == S(:,j));
      #for k = 1:size(S)(1)
      #  if S(k,i) == S(k,j)
      #    c = c + 1;
      #  end
      #end
      JS(i, j) = c;
      JS(j, i) = c;
    end
  end
  
  JS = JS ./ size(S)(1);