$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2.67], [0.782, 0.782], [2.67, 0], [5.33, 0], [7.218, 0.782], [8, 2.67], [8, 17.33], [7.218, 19.218], [5.33, 20], [24.67, 20], [22.782, 19.218], [22, 17.33], [22, 2.67], [22.782, 0.782], [24.67, 0], [27.33, 0], [29.218, 0.782], [30, 2.67], [30, 27.33], [29.218, 29.218], [27.33, 30], [2.67, 30], [0.782, 29.218], [0, 27.33]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
