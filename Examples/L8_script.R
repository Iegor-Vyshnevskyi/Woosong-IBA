
# Load the packages
install.packages("tidyverse")
library(tidyverse)

# Importing review data
review_data <- read_csv("Roomba Reviews.csv")
review_data

# Using filter() and summarize()
review_data %>%
  filter(Product == "iRobot Roomba 650 for Pets") %>%
  summarize(Stars_mean = mean(Stars))

# Using group_by() and summarize()
review_data %>%
  group_by(Product) %>%
  summarize(Stars_mean = mean(Stars))

# Unstructured data
review_data %>%
  group_by(Product) %>%
  summarize(Review_mean = mean(Review))

# Summarizing with n()
review_data %>%
  summarize(Number_rows = n())

# Summarizing with n()
review_data %>%
  group_by(Product) %>%
  summarize(Number_rows = n())

# Summarizing with count()
review_data %>%
  count(Product)

# Summarizing with count() & change order
review_data %>%
  count(Product) %>%
  arrange(desc(n))

# Using unnest_tokens()
install.packages("tidytext")
library(tidytext)

tidy_review <- review_data %>%
  unnest_tokens(Word, Review)
tidy_review

# Counting words
tidy_review %>%
  count(Word) %>%
  arrange(desc(n))

# See stopwords
View(stop_words)

# Using anti_join()
tidy_review2 <- review_data %>%
  unnest_tokens(Word, Review) %>%
  anti_join(stop_words, by = c("Word" = "word"))
tidy_review2

# Counting words again
tidy_review2 %>%
  count(Word) %>%
  arrange(desc(n))

# Plotting word counts
# Our data
tidy_review <- review_data %>%
  mutate(id = row_number()) %>%
  unnest_tokens(Word, Review) %>%
  anti_join(stop_words, by = c("Word" = "word"))
tidy_review

# Visualizing counts with geom_col()
word_counts <- tidy_review %>%
  count(Word) %>%
  arrange(desc(n))
ggplot( word_counts, aes(x = Word, y = n)) +
  geom_col()

# filter() before visualizing
word_counts2 <- tidy_review %>%
  count(Word) %>%
  filter(n > 300) %>%
  arrange(desc(n))
word_counts2

# Using coord_flip()
ggplot( word_counts2, aes(x = Word, y = n)) +
  geom_col() +
  coord_flip() +
  ggtitle("Review Word Counts")

# Custom stop words
# Using tribble() and bind_rows()
custom_stop_words <- tribble( ~word, ~lexicon,
  "roomba", "CUSTOM", "2","CUSTOM")
stop_words2 <- stop_words %>%
  bind_rows(custom_stop_words)

# Removing stop words again
tidy_review <- review_data %>%
  mutate(id = row_number()) %>%
  select(id, Date, Product, Stars, Review) %>%
  unnest_tokens(Word, Review) %>%
  anti_join(stop_words2, by = c("Word" = "word"))
tidy_review
tidy_review %>%
  filter(Word == "roomba")

# Using fct_reorder()
word_counts <- tidy_review %>%
  count(Word) %>%
  filter(n > 300) %>%
  mutate(Word2 = fct_reorder(Word, n))

ggplot( word_counts, aes(x = Word2, y = n)) +
  geom_col() +
  coord_flip() +
  ggtitle("Review Word Counts")

# Faceting word count plots
# Counting by product
tidy_review %>%
  count(Word, Product) %>%
  arrange(desc(n))

# Using top_n()
tidy_review %>%
  count(Word, Product) %>%
  group_by(Product) %>%
  top_n(10, n)

# Using ungroup()
tidy_review %>%
  count(Word, Product) %>%
  group_by(Product) %>%
  top_n(10, n) %>%
  ungroup()

# Using fct_reorder() and facet_wrap()
word_counts <- tidy_review %>%
  count(Word, Product) %>%
  group_by(Product) %>%
  top_n(10, n) %>%
  ungroup() %>%
  mutate(Word2 = fct_reorder(Word, n))

ggplot(word_counts, aes(x = Word2, y = n, fill = Product)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ Product, scales = "free_y") +
  coord_flip() +
  ggtitle("Review Word Counts") +
  theme_bw()

# Plotting word clouds
# Using wordcloud()
install.packages("wordcloud")
library(wordcloud)

word_counts <- tidy_review %>%
  count(Word)
wordcloud( words = word_counts$Word,
  freq = word_counts$n,
  max.words = 30,
  colors = "green")



