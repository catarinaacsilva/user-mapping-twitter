###############################################################################
# Plots the results of the Jaccard Similarity
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################
# 1. Creates a adjacency matrix based on the threshold values
# 2. Prints the most similar pairs
# 3. If the environment is Matlab it tries to plot a graph with the pairs

function JS_Plot(List_Tweets_Filename, JS, t)
  # Replace values below threshold t to zero
  JS(JS < t) = 0;
  
  # Print list of similar Twitter users
  for i = 1:size(JS)(2)-1
    for j = i+1:size(JS)(2)
      if JS(i,j) > 0
        ui = List_Tweets_Filename{i};
        uj = List_Tweets_Filename{j};
        fprintf('User %s and %s have a similarity valeu of %f\n',ui,uj,JS(i,j));
      end
    end
  end
  
  # Create a simple adjacency matrix (1 -> vertices should be connected)
  JS(JS >= t) = 1;
  
  if isOctave == false
    G = graph(JS);
    plot G;
  else
    # Basic algorithm to emulate force-direct graph drawing
    out= [0 0; 6 6; 3 0; 3 6; 0 6; 6 0; 6 3; 0 3];
    outIdx = 1;
    in = [1 1; 5 5; 3 1; 3 5; 1 5; 5 1; 5 3; 1 3];
    inIdx = 1;
    
    # Compute mean connectivity
    c = sum(JS);
    mc = mean(c);
    crd = zeros(size(JS)(1), 2);
    
    # Distribute conectiviy points
    for i = 1:size(JS)(1)
      if c(i) < mc
        crd(i,:) = out(outIdx, :);
        outIdx = outIdx + 1;
      else
        crd(i,:) = in(inIdx, :);
        inIdx = inIdx + 1;
      end
    end
    
    figure;
    gplot (JS, crd, "o-");
    set (get (gca, ("children")), "markersize", 12);
    title ("Twitter users graph");
  end