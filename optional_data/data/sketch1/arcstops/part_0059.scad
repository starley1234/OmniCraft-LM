$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[46.712, 0], [46.161, 5.724], [44.528, 11.238], [40.819, 9.74], [37.359, 15.802], [32.411, 20.725], [26.332, 24.155], [19.559, 25.844], [12.581, 25.67], [5.901, 23.646], [0, 19.917], [6.428, 12.257], [12.842, 15.525], [20.039, 15.65], [26.563, 12.608], [31.093, 7.014], [32.712, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
