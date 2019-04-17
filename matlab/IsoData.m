###############################################################################
# IsoData: Automatic threshold algorithm 
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################
# It finds the optimal threshold for two groups.
# Used in several image processing applications.
# Can be understood as a special case of K-means clustreing.

function t = IsoData(x)
  if or(size(x) == sum(x == 0), size(x) == sum(x == 1))
    t = x(1);
  else
    iT = mean(x);
    done = false;
    
    while ~done
      m1 = mean(x((x > iT)));
      m2 = mean(x((x <= iT)));
      fT = (m1 + m2) / 2.0;
      if iT == fT
        done = true;
      else
        iT = fT;
      end
    end
    t = fT;
  end