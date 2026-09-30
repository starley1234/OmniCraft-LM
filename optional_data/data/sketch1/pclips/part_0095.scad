$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 1.67], [0.489, 0.489], [1.67, 0], [3.33, 0], [4.511, 0.489], [5, 1.67], [5, 10.33], [4.511, 11.511], [3.33, 12], [36.67, 12], [35.489, 11.511], [35, 10.33], [35, 1.67], [35.489, 0.489], [36.67, 0], [38.33, 0], [39.511, 0.489], [40, 1.67], [40, 16.33], [39.511, 17.511], [38.33, 18], [1.67, 18], [0.489, 17.511], [0, 16.33]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
