$fn = 32;

// ----------------------------------------------------------------------
// C washer: 40 x 26 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [37, 0], [40, 3], [40, 8.23], [30, 8.23], [30, 17.76], [40, 17.76], [40, 23], [37, 26], [3, 26], [0, 23], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
