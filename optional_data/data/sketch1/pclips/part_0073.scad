$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 1.67], [0.489, 0.489], [1.67, 0], [3.33, 0], [4.511, 0.489], [5, 1.67], [5, 26.33], [4.511, 27.511], [3.33, 28], [36.67, 28], [35.489, 27.511], [35, 26.33], [35, 1.67], [35.489, 0.489], [36.67, 0], [38.33, 0], [39.511, 0.489], [40, 1.67], [40, 34.33], [39.511, 35.511], [38.33, 36], [1.67, 36], [0.489, 35.511], [0, 34.33]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
