$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[34.84, 0], [34.326, 5.343], [32.802, 10.489], [25.384, 7.492], [23.309, 11.349], [20.444, 14.661], [16.927, 17.27], [12.926, 19.052], [8.633, 19.919], [4.255, 19.832], [0, 18.794], [4.104, 7.518], [7.12, 7.995], [10.094, 7.308], [12.595, 5.557], [14.258, 2.997], [14.84, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
