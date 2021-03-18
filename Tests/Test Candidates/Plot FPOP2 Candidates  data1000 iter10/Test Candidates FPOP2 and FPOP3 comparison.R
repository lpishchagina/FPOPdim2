CandidatesFPOP2 <- readLines(con = 'FPOP2 Candidates  data1000 iter10.txt', n = -1)
CandidatesFPOP3 <- readLines(con = 'FPOP3 Candidates  data1000 iter10.txt', n = -1)


CandidatesFPOP2 <- strsplit(CandidatesFPOP2,split = ' ')
CandidatesFPOP3 <- strsplit(CandidatesFPOP3,split = ' ')

CandidatesFPOP2<- sapply(CandidatesFPOP2, FUN = function(x) {as.double(unlist(x))})
CandidatesFPOP3 <- sapply(CandidatesFPOP3, FUN = function(x) {as.double(unlist(x))})

png(filename = "Plot FPOP2 and FPOP3 Candidates comparison data1000.png",  width = 1500, height = 1000)

plot(CandidatesFPOP3, main = "FPOP2 and FPOP3:Candidates", xlab = "Time", ylab = "Number of candidates(mean) being considered", col = "purple3")
lines(CandidatesFPOP3, col= "purple3", lwd = 3)
points(CandidatesFPOP2, col= "royalblue3")
lines(CandidatesFPOP2, col= "royalblue3", lwd = 3)
##############
#   legend   #
##############
location = "topright"
labels = c("FPOP2","FPOP3")
colors = c("royalblue3", "purple3")
legend(location, labels, fill = colors)
dev.off()



