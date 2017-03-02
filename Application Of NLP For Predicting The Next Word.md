Predicting The Next Word
========================================================
author: Abhijit Jantre
date: 28th February,2017
autosize: true

The Goal
========================================================

- The goal of this project is to create an algorithm to predict the next word based on the previous word(s) typed by the user.

-  I have used 3 databases of english sentences extracted from news, blogs and twitter.

- At first, I built the relationship between words. Then, I employed exploratory analysis to build an n-gram model for predicting the next word based on the previous 1, 2, or 3 words.

- All text mining and natural language processing was done using various R packages.


The Methodology
========================================================


-  I built a basic n-gram model with the natural language processing (NLP) which can be accessed by clicking on the link

   http://rpubs.com/abhijitjantre/NgramModelWithNaturalLanguageProcessingNLP

-  Subsequently, I created R code for predicting the next word.

-  I have then created ngram and used it in conjuction with the R code for predicting the next word.

- Finally, I deployed the application on shinywebserver.

  https://abhijitjantre.shinyapps.io/Final/

User Interface And Application
========================================================
The user types the word/phrase/text and clicks on the button named 'Submit For Prediction'. Subsequently, three outcomes appear on the right hand panel of the screen namely

- Cleaned Text
- First Best Prediction
- Second Best Prediction

<img src="Application Of NLP For Predicting The Next Word-figure/unnamed-chunk-1-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="870px" height="280px" style="display: block; margin: auto;" />


References And APP Related Publications
=======================================================

**References**

- http://en.wikipedia.org/wiki/N-gram
- https://class.coursera.org/dsscapstone-002

**My App Publications**
- On Shiny Apps   : https://abhijitjantre.shinyapps.io/Final/
- Code On Git Hub : https://github.com/abhijitjantre/DataScienceCapstoneProject
