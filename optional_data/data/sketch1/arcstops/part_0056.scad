$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[48.712, 0], [48.401, 4.454], [47.473, 8.82], [41.705, 7.167], [38.693, 13.888], [33.916, 19.494], [27.759, 23.537], [20.716, 25.69], [13.351, 25.782], [6.256, 23.805], [0, 19.917], [5.142, 13.789], [12.358, 17.465], [20.455, 17.607], [27.794, 14.184], [32.891, 7.891], [34.712, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
