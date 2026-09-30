$fn = 32;

// ----------------------------------------------------------------------
// C washer: 50 x 26 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [47, 0], [50, 3], [50, 9.03], [32.5, 9.03], [32.5, 16.97], [50, 16.97], [50, 23], [47, 26], [3, 26], [0, 23], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
