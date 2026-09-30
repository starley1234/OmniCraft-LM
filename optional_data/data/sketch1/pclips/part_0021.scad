$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2.33], [0.682, 0.682], [2.33, 0], [4.67, 0], [6.318, 0.682], [7, 2.33], [7, 7.67], [6.318, 9.318], [4.67, 10], [35.33, 10], [33.682, 9.318], [33, 7.67], [33, 2.33], [33.682, 0.682], [35.33, 0], [37.67, 0], [39.318, 0.682], [40, 2.33], [40, 15.67], [39.318, 17.318], [37.67, 18], [2.33, 18], [0.682, 17.318], [0, 15.67]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
