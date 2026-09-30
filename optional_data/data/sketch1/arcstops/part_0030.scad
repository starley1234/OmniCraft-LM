$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[61.681, 0], [60.255, 11.612], [56.062, 22.535], [48.999, 18.779], [44.45, 25.558], [38.62, 31.273], [31.752, 35.685], [24.13, 38.611], [16.073, 39.928], [7.916, 39.582], [0, 37.588], [4.104, 26.311], [14.658, 27.983], [25.069, 25.579], [33.822, 19.45], [39.642, 10.489], [41.681, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
