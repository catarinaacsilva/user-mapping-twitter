###############################################################################
# Creates multiple hashes from 2 single ones
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################
#
# This code is used to generate multiple hashes for the bloom filter


function h = BF_Hash(key, i, m)
  a = String2Hash(key, 'djb2');
  b = String2Hash(key, 'joath');
  h = mod(int64((a+b*i)), m)+1;