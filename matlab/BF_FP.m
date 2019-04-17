###############################################################################
# Return the probability of false positives
###############################################################################
# Authors:
# --> Catarina Silva
#
###############################################################################
#
# Calculate the Probability of False Positives of a given Bloom Filter.
# Formula: (1 - e^(-k * n / m)) ^ k

function p = BF_FP(k, m, n)
  p = (1 - exp((-k*n) / m)) ^ k;