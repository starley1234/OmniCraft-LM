$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 1.67], [0.489, 0.489], [1.67, 0], [3.33, 0], [4.511, 0.489], [5, 1.67], [5, 12.33], [4.511, 13.511], [3.33, 14], [26.67, 14], [25.489, 13.511], [25, 12.33], [25, 1.67], [25.489, 0.489], [26.67, 0], [28.33, 0], [29.511, 0.489], [30, 1.67], [30, 22.33], [29.511, 23.511], [28.33, 24], [1.67, 24], [0.489, 23.511], [0, 22.33]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
