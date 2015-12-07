function data = load_text_data(path)
% Takes a path to a text file and loads it into a matrix.

filename = path;
data = importdata(filename);

end