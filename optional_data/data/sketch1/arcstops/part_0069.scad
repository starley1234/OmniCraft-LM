$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[57.681, 0], [56.374, 10.645], [52.53, 20.657], [48.999, 18.779], [44.45, 25.558], [38.62, 31.273], [31.752, 35.685], [24.13, 38.611], [16.073, 39.928], [7.916, 39.582], [0, 37.588], [2.052, 31.95], [14.867, 33.979], [27.51, 31.061], [38.138, 23.618], [45.205, 12.737], [47.681, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
