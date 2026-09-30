$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 1.67], [0.489, 0.489], [1.67, 0], [3.33, 0], [4.511, 0.489], [5, 1.67], [5, 10.33], [4.511, 11.511], [3.33, 12], [26.67, 12], [25.489, 11.511], [25, 10.33], [25, 1.67], [25.489, 0.489], [26.67, 0], [28.33, 0], [29.511, 0.489], [30, 1.67], [30, 16.33], [29.511, 17.511], [28.33, 18], [1.67, 18], [0.489, 17.511], [0, 16.33]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
