$fn = 32;

// ----------------------------------------------------------------------
// Key bar: woodruff key, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[32, 0], [31.455, 4.141], [29.856, 8], [27.314, 11.314], [24, 13.856], [20.141, 15.455], [16, 16], [11.859, 15.455], [8, 13.856], [4.686, 11.314], [2.144, 8], [0.545, 4.141], [0, 0]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
