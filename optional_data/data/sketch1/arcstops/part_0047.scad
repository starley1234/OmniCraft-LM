$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[23.212, 0], [22.38, 6.774], [19.934, 13.145], [12.871, 9.389], [11.792, 11.184], [10.533, 12.856], [9.105, 14.387], [7.525, 15.76], [5.81, 16.961], [3.979, 17.976], [2.052, 18.794], [0, 13.156], [3.04, 11.607], [5.616, 9.368], [7.573, 6.573], [8.796, 3.387], [9.212, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
