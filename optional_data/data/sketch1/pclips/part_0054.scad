$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2.67], [0.782, 0.782], [2.67, 0], [5.33, 0], [7.218, 0.782], [8, 2.67], [8, 25.33], [7.218, 27.218], [5.33, 28], [54.67, 28], [52.782, 27.218], [52, 25.33], [52, 2.67], [52.782, 0.782], [54.67, 0], [57.33, 0], [59.218, 0.782], [60, 2.67], [60, 33.33], [59.218, 35.218], [57.33, 36], [2.67, 36], [0.782, 35.218], [0, 33.33]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
