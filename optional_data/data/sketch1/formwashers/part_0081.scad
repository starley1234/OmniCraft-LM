$fn = 32;

// ----------------------------------------------------------------------
// C washer: 75 x 26 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [72, 0], [75, 3], [75, 8.23], [48.75, 8.23], [48.75, 17.76], [75, 17.76], [75, 23], [72, 26], [3, 26], [0, 23], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
