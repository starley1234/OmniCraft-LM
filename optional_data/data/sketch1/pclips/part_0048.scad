$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 1.67], [0.489, 0.489], [1.67, 0], [3.33, 0], [4.511, 0.489], [5, 1.67], [5, 12.33], [4.511, 13.511], [3.33, 14], [56.67, 14], [55.489, 13.511], [55, 12.33], [55, 1.67], [55.489, 0.489], [56.67, 0], [58.33, 0], [59.511, 0.489], [60, 1.67], [60, 22.33], [59.511, 23.511], [58.33, 24], [1.67, 24], [0.489, 23.511], [0, 22.33]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
