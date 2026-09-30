$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[34.84, 0], [34.009, 6.774], [31.563, 13.145], [24.499, 9.389], [22.225, 12.779], [19.31, 15.637], [15.876, 17.843], [12.065, 19.306], [8.036, 19.964], [3.958, 19.791], [0, 18.794], [4.104, 7.518], [7.12, 7.995], [10.094, 7.308], [12.595, 5.557], [14.258, 2.997], [14.84, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
