$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[30, 0], [29.109, 7.258], [26.488, 14.084], [22.957, 12.206], [20.803, 15.595], [18.154, 18.613], [15.072, 21.186], [11.63, 23.254], [7.911, 24.767], [4.003, 25.69], [0, 26], [0, 16], [4.944, 15.217], [9.405, 12.944], [12.944, 9.405], [15.217, 4.944], [16, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
