$fn = 32;

// ----------------------------------------------------------------------
// C washer: 75 x 30 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [72, 0], [75, 3], [75, 11.82], [56.25, 11.82], [56.25, 18.17], [75, 18.17], [75, 27], [72, 30], [3, 30], [0, 27], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
