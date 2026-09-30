$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2.67], [0.782, 0.782], [2.67, 0], [5.33, 0], [7.218, 0.782], [8, 2.67], [8, 5.33], [7.218, 7.218], [5.33, 8], [54.67, 8], [52.782, 7.218], [52, 5.33], [52, 2.67], [52.782, 0.782], [54.67, 0], [57.33, 0], [59.218, 0.782], [60, 2.67], [60, 15.33], [59.218, 17.218], [57.33, 18], [2.67, 18], [0.782, 17.218], [0, 15.33]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
