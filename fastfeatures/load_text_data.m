function [data] = load_text_data(path)
% Takes a path to a text file and loads it into a matrix.

filename = path;
delimiterIn = ' ';
headerlinesIn = 1;
data = importdata(filename, delimiterIn, headerlinesIn);

end