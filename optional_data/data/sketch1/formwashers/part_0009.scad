$fn = 32;

// ----------------------------------------------------------------------
// C washer: 60 x 26 mm plate with an open slot
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[3, 0], [57, 0], [60, 3], [60, 5], [39, 5], [39, 21], [60, 21], [60, 23], [57, 26], [3, 26], [0, 23], [0, 3]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
