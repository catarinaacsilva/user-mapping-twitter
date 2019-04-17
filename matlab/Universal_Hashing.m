###############################################################################
# Universal Hashing
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################
#
# Universal Hashing as described in the slides.
# a,b are random integer
# p is a prime number bigger than the n
# n is size of Set

function h = Universal_Hashing(x,a,b,p,n)
  h = mod(mod((a*x+b), p), n);
  #h = mod(mod((a*x+b), p), 2^32-1);