$fn = 32;

// ----------------------------------------------------------------------
// Flat adaptor: hex_disc, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 14;      // points of the closed outline

profile = [[0, 23.398], [2.377, 12.985], [4.8, 4.198], [18.659, 0], [29.341, 0], [43.2, 4.198], [45.623, 12.985], [48, 23.398], [45.623, 33.811], [43.2, 42.598], [29.341, 46.797], [18.659, 46.797], [4.8, 42.598], [2.377, 33.811]];  // single closed polygon, 14 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
