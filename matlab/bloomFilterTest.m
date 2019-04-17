###############################################################################
# Find similar users on twitter
###############################################################################
# Author:
# --> Catarina Silva
#
###############################################################################
# Plots the rate of false positives against the probability of false positives.
# Can be used to select hash functions and optimize algorithm.

# Let the print work in Octave
more off;

# Size of the bloom filter
m = 300;

# Number of hashes in the bloom filter
k = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
pfp = zeros(1, 10);
fp = zeros(1, 10);

for i = 1:size(k)(2)
  BF = BF_Init('stopWordsGoogle.csv', m, k);
  SW = ReadTextFile('stopWords.csv');
  SWG = ReadTextFile('stopWordsGoogle.csv');
  pfp(i) = BF_FP(k(i), m, size(SWG)(2));
  
  f = 0;
  for j = 1:size(SW)(2)
    if IsMember(SW{j}, SWG) != BF_IsMember(BF, k(i), SW{j})
      f = f + 1;
    end
  end
  fp(i) = f/size(SW)(2);
end

figure;

h1 = plot(k, pfp);
hold on;
h2 = plot(k, fp);

title('False Positive Rate');
xlabel('Number of hash functions');
ylabel('Probability of False Positive');
#label(h1, 'Theoretical Probability of False Positive');
#label(h1, 'Measured Probability of False Positive');