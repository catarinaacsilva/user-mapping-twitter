
import csv
import re

regex = re.compile('[^a-zA-Z]')


def f7(seq):
    seen = set()
    seen_add = seen.add
    return [x for x in seq if not (x in seen or seen_add(x))]


def clean_dataset(screen_name, n_tweets=300):
    # open CSV file
    all_words = []
    with open('%s_tweets.csv' % screen_name, 'r') as f:
        reader = csv.reader(f)
        c = 0
        for row in reader:
            if len(row) > 0:
                c += 1
                words = row[0].split()
                for w in words:
                    s = regex.sub('', w.lower()).strip()
                    if(len(s) > 2 and len(s) < 13):
                        all_words.append(s)
                if c >= n_tweets:
                    break
    # Filter out repetition
    # But since we are build shingles, there is no need
    # final_words = f7(all_words)
    #outtweets = [[word] for word in final_words]
    outtweets = [[word] for word in all_words]

    #print(final_words)
    with open('%s_tweets_words.csv' % screen_name, 'w') as f:
        writer = csv.writer(f, lineterminator='\n')
        writer.writerows(outtweets)

if __name__ == '__main__':
    for user in ['katyperry', 'TheEllenShow', 'YouTube', 'realDonaldTrump', 'BillGates',
                 'nytimes', 'CNN', 'espn', 'NASA', 'aliciakeys']:
        clean_dataset(user)
