# Week 3 Other Data Structure 
# Lists
c(4,6,"dog") #single vector answer
a <- list(4,6,"dog") #multiple vector answer
class(a) 
str(a)

b <- list(4, letters,"dog")
str(b)
length(b) #how many elements are in here? 
length(b[[2]]) #when you want to know the length of something inside the vector

#Data frames 
#picky lists/all data has to be in the same length
letters
data.frame(letters) #all data are represented in a column 
df <- data.frame(letters)
length(df)
#what does line 18 mean? use dim function 
dim(df) #26 rows, 1 column 
#another method to evalute this 
nrow(df)
ncol(df)

df2 <- data.frame(letters, letters)
str(df2) #since created two rows, R differentiates 
dim(df2)

data.frame(letters, "dog")
data.frame (letters, 1)
data.frame (letters, 1:2) # same length so it runs 
data.frame (letters, 1:3) # can't distribute 1,2,3 equally so R warns you

#matrices
#same exact type of data; two dimensional
matrix(nrow = 10, ncol = 10) #no values example
matrix(1:10, nrow = 10, ncol = 10, byrow= TRUE) #sequence values across rows by using byrow
m <- matrix(1:10, nrow = 10, ncol = 10, byrow= TRUE)
m[1,3]
m[c(1,2), c(5,6)]

#arrays

#factors - fancy characters that have leveled value 
response <- factor(c("no", "yes", "maybe", "no", "maybe", "no"))
class(response)
levels(response) #R assigned different levels to the responses
nlevels(response) #number of unique levels in the factor 
typeof(response) #R sees it as a level not a word 
response

#how to change order ot the responses from typeof function 
response <- factor(response, levels = c("yes", "maybe", "no"))
response

#convert to as character
as.character(response)
year_fct <- factor(c(1990, 1983, 1977, 1998,1990))
year_fct
as.numeric(year_fct) #R assigns levels
as.numeric(as.character(year_fct)) #R tells you in order of the sequence

#Renaming the different levels of data
levels(response)
levels(response)[1] <- "YES"
response

#change name of all three levels 
levels(response) <-c("YES", "MAYBE", "NO")
response
