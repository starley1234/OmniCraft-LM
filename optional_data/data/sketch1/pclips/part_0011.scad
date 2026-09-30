$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 1.67], [0.489, 0.489], [1.67, 0], [3.33, 0], [4.511, 0.489], [5, 1.67], [5, 24.33], [4.511, 25.511], [3.33, 26], [26.67, 26], [25.489, 25.511], [25, 24.33], [25, 1.67], [25.489, 0.489], [26.67, 0], [28.33, 0], [29.511, 0.489], [30, 1.67], [30, 34.33], [29.511, 35.511], [28.33, 36], [1.67, 36], [0.489, 35.511], [0, 34.33]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
