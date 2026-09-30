$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 1.67], [0.489, 0.489], [1.67, 0], [3.33, 0], [4.511, 0.489], [5, 1.67], [5, 22.33], [4.511, 23.511], [3.33, 24], [46.67, 24], [45.489, 23.511], [45, 22.33], [45, 1.67], [45.489, 0.489], [46.67, 0], [48.33, 0], [49.511, 0.489], [50, 1.67], [50, 28.33], [49.511, 29.511], [48.33, 30], [1.67, 30], [0.489, 29.511], [0, 28.33]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
