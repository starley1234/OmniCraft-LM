$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[61.681, 0], [61.214, 6.68], [59.821, 13.231], [52.131, 11.025], [48.52, 19.654], [43.003, 27.207], [35.883, 33.273], [27.549, 37.519], [18.457, 39.714], [9.103, 39.737], [0, 37.588], [2.736, 30.07], [14.798, 31.981], [26.696, 29.233], [36.7, 22.229], [43.351, 11.987], [45.681, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
