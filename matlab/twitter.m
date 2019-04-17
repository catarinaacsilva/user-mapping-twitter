###############################################################################
# Find similar users on twitter
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################

# Let the print work in Octave
more off;

###############################################################################
# Parameters
###############################################################################

# Size of the bloom filter
m = 300;

# Number of hashes in the bloom filter
k = 5;

# Shingle size
s = 1;

# Number of hashs used in Min Hash signature
mhk = 5000;

###############################################################################
# Load stopword and create a bloom filter
###############################################################################
# StopWords collected from this site: https://www.ranks.nl/stopwords

disp('Load Stop Words into a Bloom Filter');
BF = BF_Init('stopWords.csv', m, k);

###############################################################################
# Load tweets from 10 popular twitter users
###############################################################################
# Some preprocessing was done in python.
# However, Bloom Filter will be used to remove stop words.

List_Tweets_Filename = {'katyperry', 'TheEllenShow', 'YouTube', 'realDonaldTrump', 'BillGates', 'nytimes', 'CNN', 'espn', 'NASA', 'aliciakeys'};

disp ('Load tweet words and remove Stop Words using the Bloom Filter');
for i = 1:size(List_Tweets_Filename)(2)
  disp(List_Tweets_Filename{i});
  LT{i} = ReadTweetsRemoveStopWords(strcat(List_Tweets_Filename{i}, '_tweets_words.csv'), BF, k);  
end

###############################################################################
# Create Shingles from the tweet words
###############################################################################
#

disp ('Create shingles from the tweet words');
for i = 1:size(LT)(2)
  LS{i} = MH_Shingles(LT{i}, s);
end

###############################################################################
# Creates a Set membership matrix
###############################################################################
# 1. Identify all the shingles
# 2. Creates a membership matrix based on the shingles

disp ('Create a Set Matrix from all the Shingles');
MS = MH_Shingle2Set(LS);

###############################################################################
# Creates a signature matrix
###############################################################################
#

disp ('Create Min Hash Signatures from the Set Matrix');
S = MH_Set2Signature(MS, mhk);

###############################################################################
# Computes the Jaccard Similarity from the MinHash signatures
###############################################################################
#

disp ('Compute Jaccard Similarity');
tic
MHJS = MH_JaccardSimilarity(S);
MHT = toc;

###############################################################################
# Computes automatic thresholds in order to present the results
###############################################################################
# Average and IsoData can be used to compute a automatic threshold.
# IsoData appears to be more robbust.
# However, it can locked if there are only zeros in the matrix.

disp ('Compute Threshold');
# Trick to remove diagonal from the threshold
M = MHJS;
M(logical(eye(size(MHJS)))) = 0;
#t = mean(MHJS(:));
t = IsoData(M(:));


###############################################################################
# Prints the results
###############################################################################
# 1. Creates a adjacency matrix based on the threshold values
# 2. Prints the most similar pairs
# 3. If the environment is Matlab it tries to plot a graph with the pairs 

disp('Plot similarities as a Graph (cut off by average similarity)');
JS_Plot(List_Tweets_Filename, MHJS, t);

###############################################################################
# Compute the Jaccard Similarity without MinHash
###############################################################################
# 

disp('Computes Jaccard Similary without MinHash');
tic
JS = JaccardSimilarity(MS);
JST = toc;

###############################################################################
# Computes automatic thresholds in order to present the results
###############################################################################
#

disp ('Compute Threshold');
# Trick to remove diagonal from the threshold
M = JS;
M(logical(eye(size(JS)))) = 0;
#t = mean(JS(:));
t = IsoData(M(:));

###############################################################################
# Prints the results
###############################################################################
#

disp('Plot similarities as a Graph (cut off by average similarity)');
JS_Plot(List_Tweets_Filename, JS, t);

###############################################################################
# Evaluate MinHash vs Normal Jaccard
###############################################################################
#

rmse = sqrt(mean(((MHJS - JS).^2)(:)));
speedup = JST / MHT;

fprintf("Root Mean Square Error between MinHash and conventional Jaccards: %f\n", rmse);
fprintf("SpeedUp MinHash and conventional Jaccards: %f\n", speedup);