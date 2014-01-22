with open('input.txt', 'r') as infile, open('stopwords.js', 'w') as outfile:
  data = []
  for line in infile:
    line = line.rstrip()
    data.append(line)

  data = list(set(data))
  data.sort()

  outfile.write("var stopwords = {")
  for d in data:
    outfile.write("\""+d+"\":1,")
  outfile.write("}")
