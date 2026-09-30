$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 1.67], [0.489, 0.489], [1.67, 0], [3.33, 0], [4.511, 0.489], [5, 1.67], [5, 28.33], [4.511, 29.511], [3.33, 30], [46.67, 30], [45.489, 29.511], [45, 28.33], [45, 1.67], [45.489, 0.489], [46.67, 0], [48.33, 0], [49.511, 0.489], [50, 1.67], [50, 34.33], [49.511, 35.511], [48.33, 36], [1.67, 36], [0.489, 35.511], [0, 34.33]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
