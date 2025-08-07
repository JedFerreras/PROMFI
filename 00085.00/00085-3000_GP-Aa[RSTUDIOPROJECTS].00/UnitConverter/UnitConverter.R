library(measurements)

myset <- c(5200.9, 2133.6, 406.4)

for (i in 1:length(myset)) {
  print(conv_unit(myset[i], "mm", "inch"))
}