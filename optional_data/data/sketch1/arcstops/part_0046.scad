$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[56.569, 0], [55.5, 8.709], [52.355, 16.901], [48.824, 15.023], [44.135, 21.648], [37.931, 26.881], [30.609, 30.384], [22.642, 31.933], [14.542, 31.427], [6.829, 28.9], [0, 24.513], [7.713, 15.321], [15.731, 19.406], [24.727, 19.563], [32.882, 15.76], [38.545, 8.767], [40.569, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
